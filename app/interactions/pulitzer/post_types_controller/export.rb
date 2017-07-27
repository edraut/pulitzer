class Pulitzer::PostTypesController::Export

  def initialize(post_type)
    @post_type = post_type
  end

  def call
    json_hash = @post_type.as_json(
      except: [:id, :created_at, :updated_at],
      include: {
        post_type_versions: Pulitzer::PostTypeVersion.export_config
      }
    )

    Pulitzer::PostTypeVersion.convert_hash_to_nested(json_hash).to_json
  end
end
