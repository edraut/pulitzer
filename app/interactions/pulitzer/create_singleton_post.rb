class Pulitzer::CreateSingletonPost
  attr_accessor :post_type_version, :title

  def initialize(post_type_version)
    self.post_type_version = post_type_version
    self.title = post_type_version.name
  end

  def call
    if post_type_version.singular? && !post_type_version.posts.any?
      singleton_post = post_type_version.posts.create(title: title)
      singleton_post.create_preview_version
      Pulitzer::CreatePostContentElements.new(singleton_post).call
    end
  end
end
