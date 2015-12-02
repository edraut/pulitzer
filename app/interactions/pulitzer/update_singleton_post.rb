class Pulitzer::UpdateSingletonPost
  attr_accessor :post_type, :title

  def initialize(post_type, title)
    self.post_type = post_type
    self.title = title
  end

  def call
    if post_type.singular?
      unless post_type.singleton_post?
        Pulitzer::CreateSingletonPost.new(post_type, title).call
      else
        post_type.singleton_post.update(title: title)
      end
    end
  end
end
