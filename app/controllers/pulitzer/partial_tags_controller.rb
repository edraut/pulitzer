class Pulitzer::PartialTagsController < Pulitzer::ApplicationController
  def new
    @tag_model = params[:tag_model]
    @partial = Pulitzer::Partial.find params[:partial_id]
    @partial_tag = @partial.partial_tags.new label_type: @tag_model
    render partial: 'new', locals: { tag_model: @tag_model, partial_tag: @partial_tag, partial: @partial }
  end
end
