require "./lib"

struct ImageSize
  getter width = 0
  getter height = 0

  private def initialize(@width, @height)
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
    LibStbi.stbi_info_from_memory bytes, bytes.size, out w, out h,
      Pointer(LibC::Int).null
    self.new w, h
  end

  private def self.get_webp(bytes : Bytes) : ImageSize
    LibWebP.WebPGetInfo bytes, bytes.size, out w, out h
    self.new w, h
  end
end
