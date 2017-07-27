class Pulitzer::PostsController::Export

  def initialize(post)
    @post = post
  end

  def call
    json_hash = @post.as_json(
      Pulitzer::Post.export_config
    )
    Pulitzer::Post.convert_hash_to_nested(json_hash).to_json
  end
end
