class Pulitzer::DestroyPostTypeFreeFormSections
  attr_accessor :post_type_version, :ffst

  def initialize(ffst)
    self.post_type_version  = ffst.post_type_version
    self.ffst      = ffst
  end

  def call
    post_type_version.posts.each do |post|
      post.preview_version.free_form_sections.where(free_form_section_type_id: ffst.id).each do |ffs|
        ffs.destroy
      end
    end
  end
end
