#include <stdlib.h>
#include <string.h>
#include "libwebp-1.1.0/src/webp/types.h"
#include "libwebp-1.1.0/src/webp/decode.h"
#include "libwebp-1.1.0/src/webp/encode.h"

size_t WebPResizeRGB(const uint8_t* rgb, int width, int height, int stride, int target_width, int target_height, float quality_factor, uint8_t** output);
