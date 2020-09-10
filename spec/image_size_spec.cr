require "./spec_helper"

describe ImageSize do
  it "reads JPEG file correctly" do
    size = ImageSize.get "spec/test.jpg"
    size.width.should eq 550
    size.height.should eq 368
  end

  it "reads WebP file correctly" do
    size = ImageSize.get "spec/test.webp"
    size.width.should eq 550
    size.height.should eq 368
  end
end
