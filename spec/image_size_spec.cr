require "./spec_helper"

describe ImageSize do
  it "reads JPEG file" do
    size = ImageSize.get "spec/test.jpg"
    size.width.should eq 550
    size.height.should eq 368
  end

  it "reads WebP file" do
    size = ImageSize.get "spec/test.webp"
    size.width.should eq 550
    size.height.should eq 368
  end

  it "resizes JPEG file" do
    bytes = ImageSize.resize "spec/test.jpg", width: 100
    File.write "/tmp/test.jpg", bytes
    size = ImageSize.get "/tmp/test.jpg"
    size.width.should eq 100
    size.height.should eq 67
  end

  it "resizes WebP file" do
    bytes = ImageSize.resize "spec/test.webp", width: 100
    File.write "/tmp/test.webp", bytes
    size = ImageSize.get "/tmp/test.webp"
    size.width.should eq 100
    size.height.should eq 67
  end
end
