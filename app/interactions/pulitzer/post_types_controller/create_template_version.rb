class Pulitzer::PostTypesController::CreateTemplateVersion

  def initialize(post_type)
    @post_type = post_type
  end

  def call
    post_type_version = @post_type.post_type_versions.create
    CreateSingletonPost.new(post_type_version).call
  end

end