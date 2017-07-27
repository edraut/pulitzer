class Pulitzer::LayoutsController < Pulitzer::ApplicationController
  before_action :get_layout, only: [:show, :edit, :update, :destroy]

  def new
    @layout = Pulitzer::Layout.new(layout_params)
    @post_type = @layout.post_type
    render partial: 'new', locals: {layout: @layout}
  end

  def create
    @layout = Pulitzer::Layout.create(layout_params)
    render partial: 'show_wrapper', locals: {layout: @layout}
  end

  def show
    render partial: 'show', locals: {layout: @layout}
  end

  def edit
    render partial: 'form', locals: {layout: @layout}
  end

  def update
    @layout.update_attributes(layout_params)
    render partial: 'show', locals: {layout: @layout}
  end

  def destroy
    @layout.destroy
    head :ok and return
  end

  protected

  def get_layout
    @layout = Pulitzer::Layout.find(params[:id])
  end

  def layout_params
    params[:layout].permit!
  end

end
