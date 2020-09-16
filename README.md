# image_size.cr

![CI](https://github.com/hkalexling/image_size.cr/workflows/CI/badge.svg)

Get and modify the image dimension (width and height) of various image types.

Supported types:

- through [`stb_image.h`](https://github.com/nothings/stb/blob/master/stb_image.h): JPG, PNG, TGA, BMP, PSD, GIF, HDR, PIC
- through [`libwebp`](https://github.com/webmproject/libwebp): WebP

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
 image_size:
   github: hkalexling/image_size.cr
```

2. Run `shards install`

## Usage

```crystal
require "image_size"

# Get dimension from the path to the image file
size = ImageSize.get "test.png"
pp size.width
pp size.height

# Get dimension from binary data
file = File.new "test.png"
bytes = Bytes.new file.size
file.read bytes
file.close
size = ImageSize.get bytes
pp size.width
pp size.height

# Resize the image width to 1024. The height is automatically calculated
#	to keep the aspect ratio
bytes = ImageSize.resize "test.png", width: 1024
File.write "test-1024.png", bytes

# Resize the image height to 256. The width is automatically calculated
#	to keep the aspect ratio
bytes = ImageSize.resize "test.png", height: 256
File.write "test-256.png", bytes

# Resize the image dimension to 1024 x 1024
bytes = ImageSize.resize "test.png", width: 1024, height: 1024
File.write "test-1024-1024.png", bytes
```

## Contributors

- [Alex Ling](https://github.com/hkalexling) - creator and maintainer
