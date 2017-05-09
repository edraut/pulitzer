class Pulitzer::PartialTypesController < Pulitzer::ApplicationController
  #before_filter :get_ffst, only: [:show, :edit, :update, :destroy]

  def index
    @ffst = Pulitzer::FreeFormSectionType.find(params[:ffst_id])
    @partial_types = @ffst.partial_types
    render partial: 'index', locals: { ffst: @ffst }
  end

  def new
    @ffst = Pulitzer::FreeFormSectionType.find(params[:ffst_id])
    @partial_type = @ffst.partial_types.build
    render partial: 'new', locals: { ffst: @ffst, partial_type: @partial_type }
  end

  def create
    binding.pry
    @post_type = Pulitzer::PostType.find(ffst_params[:post_type_id])
    @ffst = @post_type.free_form_section_types.create(ffst_params)
    Pulitzer::CreatePostTypeFreeFormSections.new(@ffst).call
    render partial: 'show_wrapper', locals: {ffst: @ffst}
  end

  def show
    render partial: 'show', locals: {ffst: @ffst}
  end

  def edit
    render partial: 'form', locals: {ffst: @ffst}
  end

  def update
    old_label = @ffst.name
    @ffst.update_attributes(ffst_params)
    Pulitzer::UpdatePostTypeFreeFormSections.new(@ffst, old_label).call
    render partial: 'show', locals: {ffst: @ffst}
  end

  def destroy
    @ffst.destroy
    Pulitzer::DestroyPostTypeFreeFormSections.new(@ffst).call
    render nothing: true
  end

  protected

  def get_ffst
    @ffst = Pulitzer::FreeFormSectionType.find(params[:id])
  end

  def partial_type_params
    params[:partial_type].permit!
  end

end
