class Pulitzer::CloneVersion
  attr_accessor :version, :action, :new_version

  def initialize(version, action)
    self.version      = version
    self.action       = action
    self.new_version  = version.post.create_version
  end

  def call
    version.content_elements.each do |ce|
      new_version.content_elements << ce.clone
    end
    version.post_tags.each do |pt|
      new_version.post_tags << pt.clone
    end
    version.update status: action
  end

end
