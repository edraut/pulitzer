class Pulitzer::UpdateSingletonPost
  attr_accessor :post_type, :title

  def initialize(post_type, title)
    self.post_type = post_type
    self.title = title
  end

  def call
    if post_type.singular?
      post_type.preview_type_versions.each do |ptv|
        unless ptv.singleton_post?
          Pulitzer::CreateSingletonPost.new(ptv).call
        else
          ptv.singleton_post.update(title: title)
        end
      end
    end
  end
end
