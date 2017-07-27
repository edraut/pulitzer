class Pulitzer::FreeFormSectionTypesController < Pulitzer::ApplicationController
  before_action :get_ffst, only: [:show, :edit, :update, :destroy]

  def new
    @post_type_version = Pulitzer::PostTypeVersion.find(params[:post_type_version_id])
    @ffst = @post_type_version.free_form_section_types.build
    render partial: 'new', locals: {ffst: @ffst}
  end

  def create
    @post_type_version = Pulitzer::PostTypeVersion.find(ffst_params[:post_type_version_id])
    @ffst = @post_type_version.free_form_section_types.create(ffst_params)
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
    head :ok and return
  end

  protected

  def get_ffst
    @ffst = Pulitzer::FreeFormSectionType.find(params[:id])
  end

  def ffst_params
    params[:free_form_section_type].permit!
  end

end
