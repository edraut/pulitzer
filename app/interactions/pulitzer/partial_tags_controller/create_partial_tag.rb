class Pulitzer::PartialTagsController::CreatePartialTag

  def initialize(params)
    @request_params = params
  end

  def call
    label_id = partial_tag_params[:label_id]
    unless (Integer(label_id) rescue false)
      tag = Pulitzer::Tag.where(name: label_id).first_or_create
      @request_params[:partial_tag][:label_id] = tag.id
    end
    Pulitzer::PartialTag.create partial_tag_params
  end

  def partial_tag_params
    @request_params[:partial_tag].permit!
  end
end
