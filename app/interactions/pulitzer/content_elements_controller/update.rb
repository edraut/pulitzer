class Pulitzer::ContentElementsController::Update

  def initialize(content_element, params)
    @content_element, @params = content_element, params.to_h.to_hash.symbolize_keys
  end

  def call
    prune_params
    @content_element.update @params
  end

  def prune_params
    clickable_kind = @params.delete :clickable_kind
    custom_option_list = GlobalID::Locator.locate(clickable_kind)
    if custom_option_list.present?
      @params[:body] = nil
    else
      @params[:custom_option_id] = nil
    end
  end
end