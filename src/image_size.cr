require "./lib"

struct ImageSize
  getter width = 0
  getter height = 0
  getter components = 0

  private def initialize(@width, @height, @components = 0)
  end

  def self.get(bytes : Bytes)
    if self.is_webp bytes
      self.get_webp bytes
    else
      self.get_stbi bytes
    end
  end

  def self.get(filename : String)
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

  def self.resize(bytes : Bytes, *, width = 0, height = 0) : Bytes
    size = self.get bytes
    if width == 0 && height == 0
      raise "At least one of the named arguments `width:` and `height:` " \
            "must be non-zero"
    elsif width == 0
      width = (height / size.height * size.width).round.to_i
    else
      height = (width / size.width * size.height).round.to_i
    end

    if self.is_webp bytes
      self.webp_resize bytes, self.new width, height
    else
      self.stbi_resize bytes, self.new width, height
    end
  end

  def self.resize(filename : String, *, width = 0, height = 0) : Bytes
    file = File.new filename
    bytes = Bytes.new file.size
    file.read bytes
    file.close
    self.resize bytes, width: width, height: height
  end
end
