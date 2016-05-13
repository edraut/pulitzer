class Pulitzer::PartialsController < Pulitzer::ApplicationController
  before_filter :set_partial, only: [:show, :edit, :update]

  def new
    @partial = Pulitzer::Partial.new(partial_params)
    @version = @partial.version
    render partial: 'new', locals: { partial: @partial }
  end

  def create
    @version = Pulitzer::Version.find partial_params[:version_id]
    @partial = @version.partials.create partial_params
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
    partials.each do |ce|
      new_sort_order = params[:partial].index(ce.id.to_s)
      ce.update_attribute(:sort_order, new_sort_order)
    end
    render nothing: true
  end

  protected

  def partial_params
    params[:partial].permit!
  end

  def set_partial
    @partial = Pulitzer::Partial.find(params[:id])
  end
end
