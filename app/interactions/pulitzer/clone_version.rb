class Pulitzer::CloneVersion
  attr_accessor :version, :action, :new_version

  def initialize(version, new_version)
    self.version      = version
    self.new_version  = new_version
  end

  def call
    version.content_elements.each do |ce|
      element = ce.dup
      clone_image(ce, element)
      element.version_id = nil
      new_version.content_elements << element
    end
    version.post_tags.each do |pt|
      post_tag = pt.dup
      post_tag.version_id = nil
      new_version.post_tags << post_tag
    end
  end

private
  def clone_image(original, destination)
    if original.image.file && original.image.file.exists?
      begin
        destination.image = original.image.file
      rescue
        destination.remove_image!
      end
    end
  end
end
