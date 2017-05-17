class Pulitzer::PostTypeVersion::Publish
  include StateMachine::Transition

  self.action_name = :publish
  self.target_state = 'published'
  self.valid_from_states = [:preview,:retired]

  def initialize(post_type_version)
    @post_type_version = post_type_version
    self.object = @post_type_version
    self.errors = ActiveModel::Errors.new(self)
    @old_published = get_old_published_version
  end

  def publish
    self.validate_transition!
    validate_published_post or return false
    update_status
    archive_old_version
    return true
  end

  def archive_old_version
    @old_published.update(status: 'archived') if @old_published.present?
  end

  def get_old_published_version
    @post_type_version.post_type.published_type_version
  end

  def validate_published_post
    if @post_type_version.posts.none?{|post| post.active_version.present?}
      @post_type_version.errors.add(:base, 'You must publish a post before publishing the post type')
      return false
    end
    return true
  end
end
