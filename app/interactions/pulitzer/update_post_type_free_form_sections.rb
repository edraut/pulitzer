class Pulitzer::UpdatePostTypeFreeFormSections
  attr_accessor :post_type, :ffst, :old_label

  def initialize(ffst, old_label=nil)
    self.post_type  = ffst.post_type
    self.ffst       = ffst
    self.old_label  = old_label || ffst.label
  end

  def call
    post_type.posts.each do |post|
      post.preview_version.free_form_sections.where(free_form_section_type_id: ffst.id).each do |ffs|
        ffs.update(name: ffst.name)
      end
    end
  end
end
