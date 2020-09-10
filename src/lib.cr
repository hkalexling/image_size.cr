@[Link(ldflags: "-L#{__DIR__}/../ext/stbi/ -lstbi -static")]
lib LibStbi
  fun stbi_info_from_memory(buffer : LibC::UChar*, size : LibC::SizeT, width : LibC::Int*, height : LibC::Int*, component : LibC::Int*) : LibC::Int
end

@[Link(ldflags: "-L#{__DIR__}/../ext/libwebp/ -lwebp -static")]
lib LibWebP
  fun WebPGetInfo(data : LibC::UInt8T*, size : LibC::SizeT, width : LibC::Int*, height : LibC::Int*) : LibC::Int
end
