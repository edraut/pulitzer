class Pulitzer::PostTypeVersionsController::ClonePostWithVersionElements

  def initialize(post, new_post_type_version)
    @post         = post
    @new_post_type_version  = new_post_type_version
  end

  def call
    new_post = @new_post_type_version.posts.create(title: @post.title)
    @post.clonable_versions.each do |version|
      processing_version = new_post.create_processing_version
      Pulitzer::CloneVersion.new(version, processing_version).call
    end
  end
end
