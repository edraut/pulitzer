class Pulitzer::PostTypeContentElementTypesController < Pulitzer::ApplicationController
  before_action :get_ptcet, only: [:show, :edit, :update, :destroy]

  def new
    @post_type = Pulitzer::PostType.find(params[:post_type_id])
    @ptcet = @post_type.post_type_content_element_types.build
    render partial: 'new', locals: {ptcet: @ptcet}
  end

  def create
    @post_type = Pulitzer::PostType.find(ptcet_params[:post_type_id])
    @ptcet = @post_type.post_type_content_element_types.create(ptcet_params)
    Pulitzer::CreatePostTypeContentElements.new(@ptcet).call
    render partial: 'show_wrapper', locals: {ptcet: @ptcet}
  end

  def show
    render partial: 'show', locals: {ptcet: @ptcet}
  end

  def edit
    render partial: 'form', locals: {ptcet: @ptcet}
  end

  def update
    old_label = @ptcet.label
    @ptcet.update_attributes(ptcet_params)
    Pulitzer::UpdatePostTypeContentElements.new(@ptcet, old_label).call
    render partial: 'show', locals: {ptcet: @ptcet}
  end

  def destroy
    @ptcet.destroy
    Pulitzer::DestroyPostTypeContentElements.new(@ptcet).call
    head :ok
  end

  protected

  def get_ptcet
    @ptcet = Pulitzer::PostTypeContentElementType.find(params[:id])
  end

  def ptcet_params
    params[:post_type_content_element_type].permit!
  end

end
