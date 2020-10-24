require "./lib"

struct ImageSize
  getter width = 0
  getter height = 0

  # :nodoc:
  getter components = 0

  private def initialize(@width, @height, @components = 0)
  end

  # Gets image size from binary data.
  # ```
  # file = File.new "test.png"
  # bytes = Bytes.new file.size
  # file.read bytes
  # file.close
  # size = ImageSize.get bytes
  # pp size.width
  # pp size.height
  # ```
  def self.get(bytes : Bytes) : ImageSize
    if self.is_webp bytes
      self.get_webp bytes
    else
      self.get_stbi bytes
    end
  end

  # Gets image size from filename.
  # ```
  # size = ImageSize.get "test.png"
  # pp size.width
  # pp size.height
  # ```
  def self.get(filename : String) : ImageSize
    file = File.new filename
    bytes = Bytes.new file.size
    file.read bytes
    file.close
    self.get bytes
  end

  private def self.is_webp(bytes : Bytes) : Bool
    # The first 4 bytes of a WebP file would be RIFF
    # https://developers.google.com/speed/webp/docs/
    #   riff_container#webp_file_header
    String.new(bytes[0, 4]) == "RIFF"
  end

  private def self.get_stbi(bytes : Bytes) : ImageSize
    LibStbi.stbi_info_from_memory bytes, bytes.size, out w, out h, out comp
    self.new w, h, comp
  end

  private def self.get_webp(bytes : Bytes) : ImageSize
    LibWebP.WebPGetInfo bytes, bytes.size, out w, out h
    self.new w, h
  end

  private def self.stb_load(bytes : Bytes)
    ptr = LibStbi.stbi_load_from_memory bytes, bytes.size,
      out w, out h, out comp, 0
    if ptr.null?
      msg = "stbi_image.h failed to load image"
      msg_ptr = LibStbi.stbi_failure_reason
      msg = String.new msg_ptr unless msg_ptr.null?
      raise msg
    end
    size = self.new w, h, comp
    data = Bytes.new ptr, size.width * size.height * size.components
    yield size, data
    LibStbi.stbi_image_free ptr
  end

  private def self.stbi_resize(bytes : Bytes, target : ImageSize) : Bytes
    out_bytes = Bytes.new 0
    self.stb_load bytes do |size, data|
      buffer = Bytes.new target.width * target.height * size.components
      LibStbi.stbir_resize_uint8 data, size.width, size.height,
        0, buffer, target.width, target.height, 0, size.components

      len = LibStbi.stbi_write_jpg_memory target.width, target.height,
        size.components, buffer, 100.0, out output
      out_bytes = Bytes.new output, len
    end
    out_bytes
  end

  private def self.webp_resize(bytes : Bytes, target : ImageSize) : Bytes
    ptr = LibWebP.WebPDecodeRGB bytes, bytes.size, out w, out h
    size = LibWebP.WebPResizeRGB ptr, w, h, w * 3, target.width, target.height,
      100.0, out output
    Bytes.new output, size
  end

  # Resizes an image from binary data.
  #
  # NOTE: At least one of the named arguments must be provided.
  #
  # When only `width` is set, the `height` will be automatically calculated to
  #   keep the aspect ratio.
  # ```
  # bytes = ImageSize.resize data, width: 1024
  # File.write "1024.png", bytes
  # ```
  #
  # When only `height` is set, the `width` will be automatically calculated to
  #   keep the aspect ratio.
  # ```
  # bytes = ImageSize.resize data, height: 256
  # File.write "256.png", bytes
  # ```
  #
  # Seting both `width` and `height` will break the aspect ratio.
  # ```
  # bytes = ImageSize.resize data, width: 1024, height: 1024
  # File.write "1024-1024.png", bytes
  # ```
  def self.resize(bytes : Bytes, *, width = 0, height = 0) : Bytes
    size = self.get bytes
    if width == 0 && height == 0
      raise "At least one of the named arguments `width:` and `height:` " \
            "must be non-zero"
    elsif width == 0
      width = (height / size.height * size.width).round.to_i
    elsif height == 0
      height = (width / size.width * size.height).round.to_i
    end

    if self.is_webp bytes
      self.webp_resize bytes, self.new width, height
    else
      self.stbi_resize bytes, self.new width, height
    end
  end

  # Same as `self.resize` but reads the image from a filename.
  def self.resize(filename : String, *, width = 0, height = 0) : Bytes
    file = File.new filename
    bytes = Bytes.new file.size
    file.read bytes
    file.close
    self.resize bytes, width: width, height: height
  end
end
