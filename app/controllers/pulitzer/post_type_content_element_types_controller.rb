class Pulitzer::PostTypeContentElementTypesController < Pulitzer::ApplicationController
  before_filter :get_ptcet, only: [:show, :edit, :update, :destroy]

  def new
    @post_type = Pulitzer::PostType.find(params[:post_type_id])
    @ptcet = @post_type.post_type_content_element_types.build
    render partial: 'new', locals: {ptcet: @ptcet}
  end

  def create
    @post_type = Pulitzer::PostType.find(ptcet_params[:post_type_id])
    @ptcet = @post_type.post_type_content_element_types.create(ptcet_params)
    render partial: 'show_wrapper', locals: {ptcet: @ptcet}
  end

  def show
    render partial: 'show', locals: {ptcet: @ptcet}
  end

  def edit
    render partial: 'form', locals: {ptcet: @ptcet}
  end

  def update
    @ptcet.update_attributes(ptcet_params)
    render partial: 'show', locals: {ptcet: @ptcet}
  end

  def destroy
  end

  protected

  def get_ptcet
    @ptcet = Pulitzer::PostTypeContentElementType.find(params[:id])
  end

  def ptcet_params
    params[:post_type_content_element_type].permit!
  end

end
