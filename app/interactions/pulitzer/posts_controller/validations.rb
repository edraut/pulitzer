module Pulitzer::PostsController::Validations
  def validate_title
    if Pulitzer::Post.where(title: @post.title).to_a.any?{|post|
      (post.post_type_version_id == @post.post_type_version_id)}
      @post.errors.add(:title, 'Another post already has this title')
      return false
    end
    return true
  end
end