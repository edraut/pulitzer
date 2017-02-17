class Pulitzer::ImageUploader < Pulitzer::BaseUploader

  self.aws_acl = Pulitzer.aws_acl if self.respond_to? :aws_acl

  include CarrierWave::MiniMagick

  version :cms, if: :version_available? do
    process :dynamic_resize
  end

  version :thumb, if: :version_available? do
    process resize_to_fill: [200,200]
  end

  def default_url
     Pulitzer.missing_image_path
   end

  def dynamic_resize
    resize_to_fit model.width, model.height
  end

  def version_available? photo
    true
    # !model.version_unavailable
  end

end
