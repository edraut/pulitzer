class Pulitzer::PartialsController < Pulitzer::ApplicationController
  before_action :set_partial, except: [:new, :create, :update_all]

  def new
    @partial = Pulitzer::Partial.new(partial_params)
    @free_form_section = @partial.free_form_section
    render partial: 'new', locals: { partial: @partial }
  end

  def create
    @free_form_section = Pulitzer::FreeFormSection.find partial_params[:free_form_section_id]
    @partial = @free_form_section.partials.create partial_params
    if @partial && @partial.errors.empty?
      Pulitzer::CreatePartialContentElements.new(@partial).call
      render partial: 'show_wrapper', locals: { partial: @partial }
    else
      render partial: 'new', locals: {partial: @partial}
    end
  end

  def show
    render partial: 'show', locals: { partial: @partial }
  end

  def edit
    render partial: 'form', locals: { partial: @partial }
  end

  def update
    @partial.update partial_params
    render partial: 'show', locals: { partial: @partial }
  end

  def update_all
    partials = Pulitzer::Partial.find params[:partial]
    partials.each do |partial|
      new_sort_order = params[:partial].index(partial.id.to_s)
      partial.update_attribute(:sort_order, new_sort_order)
    end
    head :ok
  end

  def destroy
    @partial.destroy
    head :ok
  end

  def upgrade
    @partial = UpgradePartialVersion.new(@partial).call
    render partial: 'show', locals: { partial: @partial }
  end

  protected

  def partial_params
    params[:partial].permit!
  end

  def set_partial
    @partial = Pulitzer::Partial.find(params[:id])
  end
end
