class Pulitzer::SequenceFlowStylesController < Pulitzer::ApplicationController
  before_action :get_sequence_flow_style, only: [:show, :edit, :update, :destroy]

  def new
    @sequence_flow_style = Pulitzer::SequenceFlowStyle.new(sequence_flow_style_params)
    render partial: 'new', locals: {sequence_flow_style: @sequence_flow_style}
  end

  def create
    @sequence_flow_style = Pulitzer::SequenceFlowStyle.create(sequence_flow_style_params)
    if @sequence_flow_style.errors.empty?
      render partial: 'show_wrapper', locals: {sequence_flow_style: @sequence_flow_style}
    else
      render partial: 'new', locals: {sequence_flow_style: @sequence_flow_style}, status: 409
    end
  end

  def show
    render partial: 'show', locals: {sequence_flow_style: @sequence_flow_style}
  end

  def edit
    render partial: 'form', locals: {sequence_flow_style: @sequence_flow_style}
  end

  def update
    @sequence_flow_style.update_attributes(sequence_flow_style_params)
    if @sequence_flow_style.errors.empty?
      render partial: 'show', locals: {sequence_flow_style: @sequence_flow_style}
    else
      render partial: 'form', locals: {sequence_flow_style: @sequence_flow_style}, status: 409
    end
  end

  def destroy
    @sequence_flow_style.destroy
    head :ok
  end

  protected

  def get_sequence_flow_style
    @sequence_flow_style = Pulitzer::SequenceFlowStyle.find(params[:id])
  end

  def sequence_flow_style_params
    params[:sequence_flow_style].permit!
  end

end
