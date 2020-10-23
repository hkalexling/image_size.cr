#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_RESIZE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#define STBI_FAILURE_USERMSG

#include "stb_image.h"
#include "stb_image_resize.h"
#include "stb_image_write.h"

size_t stbi_write_jpg_memory(int width, int height, int comp, unsigned char* ptr, float quality, unsigned char** output);
