class Pulitzer::PostTypesController::ImportVersion

  def initialize(post_type, params)
    @post_type, @params = post_type, params
    last_version_number = @post_type.post_type_versions.maximum(:version_number) || 0
    @this_version_number = last_version_number + 1
  end

  def call
    import_json = @params[:import_json].read
    ptv = @post_type.post_type_versions.build
    ptv.from_json import_json
    ptv.version_number = @this_version_number
    ptv.status = 'incomplete'
    ptv.save
    ptv
  end
end
