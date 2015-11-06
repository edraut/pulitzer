class Pulitzer::CloneVersion
  attr_accessor :version, :action, :new_version

  def initialize(version, new_version)
    self.version      = version
    self.new_version  = new_version
  end

  def call
    version.content_elements.each do |ce|
      new_version.content_elements << ce.clone
    end
    version.post_tags.each do |pt|
      new_version.post_tags << pt.clone
    end
  end

end
