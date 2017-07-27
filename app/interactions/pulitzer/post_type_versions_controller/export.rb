class Pulitzer::PostTypeVersionsController::Export

  def initialize(post_type_version)
    @post_type_version = post_type_version
  end

  def call
    json_hash = @post_type_version.as_json(
      Pulitzer::PostTypeVersion.export_config
    )
    Pulitzer::PostTypeVersion.convert_hash_to_nested(json_hash).to_json
  end
end
