class Pulitzer::CreatePostTag
  attr_accessor :post, :request_params

  def initialize(post, params)
    self.post           = post
    self.request_params = params
  end

  def call
    label_id = request_params[:post_tag][:label_id]
    unless (Integer(label_id) rescue false)
      tag = Pulitzer::Tag.where(name: label_id).first_or_create
      request_params[:post_tag][:label_id] = tag.id
    end
    post.post_tags.create post_tag_params
  end

  def post_tag_params
    request_params[:post_tag].permit!
  end
end
