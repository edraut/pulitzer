class Pulitzer::PostTypesController::Import

  def initialize(params)
    @params = params
  end

  def call
    import_json = @params[:import_json].read
    pt = Pulitzer::PostType.new
    pt.from_json import_json
    pt.save
    pt
  end
end
