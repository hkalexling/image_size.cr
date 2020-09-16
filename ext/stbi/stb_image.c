#include "./stb_image_custom.h"

typedef struct data_t {
	unsigned char* data;
	size_t capacity;
	size_t size;
} data;

data* data_init() {
	data* d = malloc(sizeof(data));
	d->capacity = 1024;
	d->size = 0;
	d->data = malloc(sizeof(unsigned char) * d->capacity);
	return d;
}

void data_free(data* d) {
	free(d->data);
	free(d);
}

void data_concat(data* d, void* new, int size) {
	if (d->size + size > d->capacity) {
		d->capacity *= 2;
		d->data = realloc(d->data, sizeof(unsigned char) * d->capacity);
	}
	memcpy(d->data + d->size, new, sizeof(unsigned char) * size);
	d->size += size;
}

void callback(void* ctx, void* ptr, int size) {
	data* d = (data*)ctx;
	data_concat(d, ptr, size);
}

size_t stbi_write_jpg_memory(int width, int height, int comp, unsigned char* ptr, float quality, unsigned char** output) {
	data* d = data_init();
    stbi_write_jpg_to_func(&callback, d, width, height, comp, ptr, quality);
	size_t size = d->size;
	*output = malloc(sizeof(unsigned char) * size);
	memcpy(*output, d->data, sizeof(unsigned char) * size);
	data_free(d);
	return size;
}
