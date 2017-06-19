class Pulitzer::UpdatePostTypeContentElements
  attr_accessor :post_type_version, :ptcet, :old_label

  def initialize(ptcet, old_label=nil)
    self.post_type_version  = ptcet.post_type_version
    self.ptcet      = ptcet
    self.old_label  = old_label || ptcet.label
  end

  def call
    post_type_version.posts.each do |post|
      begin
        preview_version = post.get_preview_version!
        post.preview_version.content_elements.where(label: old_label).each do |content_element|
          content_element.update(label: ptcet.label,
            height: ptcet.height,
            width: ptcet.width,
            text_editor: ptcet.text_editor,
            content_element_type: ptcet.content_element_type,
            post_type_content_element_type: ptcet)
        end
      rescue Pulitzer::VersionAccessError
        # if there is no preview version, skip this one.
      end
    end
    post_type_version.partials.joins(free_form_section: :version).where(pulitzer_versions: {status: 0}).each do |partial|
      partial.content_elements.where(label: old_label).each do |content_element|
        content_element.update(label: ptcet.label,
          height: ptcet.height,
          width: ptcet.width,
          text_editor: ptcet.text_editor,
          content_element_type: ptcet.content_element_type,
          post_type_content_element_type: ptcet)
      end
    end
  end
end
