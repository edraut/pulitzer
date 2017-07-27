class Pulitzer::PostsController::Create
  include Pulitzer::PostsController::Validations
  
  def initialize(params)
    @params = params
  end

  def call
    @post = Pulitzer::Post.new(@params)
    validate_title or return @post
    @post.save
    @post.create_preview_version
    @post
  end

end
