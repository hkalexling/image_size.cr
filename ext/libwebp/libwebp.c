#include "libwebp.h"

size_t WebPResizeRGB(const uint8_t* rgb, int width, int height, int stride, int target_width, int target_height, float quality_factor, uint8_t** output) {
	WebPPicture pic;
  	if (!WebPPictureInit(&pic)) return 0;
	pic.width = width;
	pic.height = height;

	if (!WebPPictureImportRGB(&pic, rgb, stride)) return 0;
	WebPPictureRescale(&pic, target_width, target_height);

	WebPMemoryWriter wrt;
	WebPMemoryWriterInit(&wrt);

	pic.writer = WebPMemoryWrite;
	pic.custom_ptr = &wrt;

	WebPConfig config;
	if (!WebPConfigPreset(&config, WEBP_PRESET_DRAWING, quality_factor)) return 0;

	if (!WebPEncode(&config, &pic)) return 0;
	WebPPictureFree(&pic);

	size_t size = wrt.size;
	*output = malloc(size);
	memcpy(*output, wrt.mem, size);

	WebPMemoryWriterClear(&wrt);

	return size;
}
