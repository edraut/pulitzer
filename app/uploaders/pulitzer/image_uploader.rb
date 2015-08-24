class Pulitzer::ImageUploader < Pulitzer::BaseUploader

  process :resize_image

  def resize_image
    self.class.process resize_to_fit: [model.width, model.height]
  end

  version :thumb do
    process resize_to_fill: [200,200]
  end
end
