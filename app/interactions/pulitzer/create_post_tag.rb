class Pulitzer::CreatePostTag

  def initialize(params)
    @request_params = params
  end

  def call
    label_id = post_tag_params[:label_id]
    unless (Integer(label_id) rescue false)
      tag = Pulitzer::Tag.where(name: label_id).first_or_create
      @request_params[:post_tag][:label_id] = tag.id
    end
    Pulitzer::PostTag.create post_tag_params
  end

  def post_tag_params
    @request_params[:post_tag].permit!
  end
end
