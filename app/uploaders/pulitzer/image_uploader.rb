class Pulitzer::ImageUploader < Pulitzer::BaseUploader

  process :resize_image

  def resize_image
    self.class.process resize_to_fit: [model.height, model.width]
  end
end
