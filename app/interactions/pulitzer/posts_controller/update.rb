class Pulitzer::PostsController::Update
  include Pulitzer::PostsController::Validations
  
  def initialize(post, params)
    @post, @params = post, params
  end

  def call
    @post.assign_attributes @params
    if @post.changes.keys.map(&:to_sym).include?(:title)
      validate_title or return @post
      @post.slug = nil
    end
    @post.save
    @post
  end

end
