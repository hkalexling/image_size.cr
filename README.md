# image_size.cr

![CI](https://github.com/hkalexling/image_size.cr/workflows/CI/badge.svg)

Get the image dimension (width and height) of various image types.

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

# Using the path to the image file
size = ImageSize.get "test.png"
pp size.width
pp size.height

# Using binary data
file = File.new "test.png"
bytes = Bytes.new file.size
file.read bytes
file.close
size = ImageSize.get bytes
pp size.width
pp size.height
```

## Contributors

- [Alex Ling](https://github.com/hkalexling) - creator and maintainer
