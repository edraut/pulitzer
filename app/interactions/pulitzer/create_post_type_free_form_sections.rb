class Pulitzer::CreatePostTypeFreeFormSections
  attr_accessor :post_type_version, :ffst, :old_label

  def initialize(ffst)
    self.post_type_version  = ffst.post_type_version
    self.ffst      = ffst
  end

  def call
    post_type_version.posts.each do |post|
      if post.preview_version
        post.preview_version.free_form_sections.create do |ffs|
          ffs.name                   = ffst.name
          ffs.free_form_section_type = ffst
        end
      end
    end
  end
end
