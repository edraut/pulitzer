class Pulitzer::CreatePostTypeFreeFormSections
  attr_accessor :post_type, :ffst, :old_label

  def initialize(ffst)
    self.post_type  = ffst.post_type
    self.ffst      = ffst
  end

  def call
    post_type.posts.each do |post|
      post.preview_version.free_form_sections.create do |ffs|
        ffs.name                   = ffst.name
        ffs.free_form_section_type = ffst
      end
    end
  end
end
