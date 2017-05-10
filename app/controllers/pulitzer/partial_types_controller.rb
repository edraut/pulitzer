class Pulitzer::PartialTypesController < Pulitzer::ApplicationController
  before_filter :get_partial_type, only: [:show, :edit, :update, :destroy]

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
    @free_form_section_type = Pulitzer::FreeFormSectionType.find partial_type_params[:free_form_section_type_id]
    @partial_type = @free_form_section_type.partial_types.create partial_type_params
    if @partial_type && @partial_type.errors.empty?
      Pulitzer::CreateFreeFormSectionPartials.new(@partial_type).call
      render partial: 'show_wrapper', locals: { partial_type: @partial_type }
    else
      render partial: 'new', locals: { partial_type: @partial_type }
    end
  end

  def show
    render partial: 'show', locals: { partial_type: @partial_type }
  end

  def edit
    render partial: 'form', locals: { partial_type: @partial_type }
  end

  def update
    old_label = @partial_type.label
    @partial_type.update_attributes(partial_type_params)
    #Pulitzer::UpdateFreeFormSectionPartials.new(@ffst, old_label).call
    render partial: 'show', locals: { partial_type: @partial_type }
  end

  def destroy
    @partial_type.destroy
    #Pulitzer::DestroyPostTypeFreeFormSections.new(@ffst).call
    head :ok
  end

  def update_all
    partial_types = Pulitzer::PartialType.find params[:partial_type]
    partial_types.each do |pt|
      new_sort_order = params[:partial_type].index(pt.id.to_s)
      pt.update_attribute(:sort_order, new_sort_order)
    end
    head :ok
  end

  protected

  def get_partial_type
    @partial_type = Pulitzer::PartialType.find(params[:id])
  end

  def partial_type_params
    params[:partial_type].permit!
  end

end
