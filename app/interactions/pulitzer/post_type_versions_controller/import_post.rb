class Pulitzer::PostTypeVersionsController::ImportPost

  def initialize(post_type_version, params)
    @post_type_version, @params = post_type_version, params
  end

  def call
    import_json = @params[:import_json].read
    post = Pulitzer::Post.new
    post.from_json import_json
    post.post_type_version = @post_type_version
    if Pulitzer::Post.where(title: post.title).to_a.any?{|other_post|
      (other_post.post_type_version_id == post.post_type_version_id)}
      post.title += ' (cloned)'
    end
    post.save
    post
  end

end
