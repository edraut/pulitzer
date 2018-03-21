class Pulitzer::PostsController::PreviewRebuilder
  attr_accessor :processing_version

  def initialize(post)
    @post = post
  end

  def rebuild
    @processing_version = @post.create_processing_version
    Pulitzer::CloneVersionJob.perform_later(@post.active_version)
    instance_eval(&Pulitzer.publish_callback) unless Pulitzer.skip_publish_callback?
  end
end
