class Pulitzer::CreateSingletonPost
  attr_accessor :post_type, :title

  def initialize(post_type, title)
    self.post_type = post_type
    self.title = title
  end

  def call
    if post_type.singular? && !post_type.singleton_post?
      singleton_post = post_type.posts.create(title: title)
      Pulitzer::CreatePostContentElements.new(singleton_post).call
    end
  end
end
