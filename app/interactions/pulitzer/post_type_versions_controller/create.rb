class Pulitzer::PostTypeVersionsController::Create

  def initialize(params, create_post=true)
    @params = params.to_h.to_hash.symbolize_keys
    @create_post = create_post
  end

  def call
    @ptv = Pulitzer::PostTypeVersion.new(@params)
    @post_type = @ptv.post_type
    last_version_number = @post_type.post_type_versions.maximum(:version_number) || 0
    this_version_number = last_version_number + 1
    @ptv.version_number = this_version_number
    @ptv.save
    ::Pulitzer::CreateSingletonPost.new(@ptv).call if @create_post
    @ptv
  end

end
