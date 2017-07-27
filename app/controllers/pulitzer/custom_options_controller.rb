module Pulitzer
  class CustomOptionsController < ApplicationController
    before_action :get_custom_option, except: [:index, :new, :create]

    def index
      @custom_options = CustomOption.all
      render_ajax
    end

    def new
      @custom_option = CustomOption.new(custom_option_params)
      render_ajax locals: { custom_option: @custom_option }
    end

    def edit
      render_ajax locals: { custom_option: @custom_option }
    end

    def show
      render_ajax locals: { custom_option: @custom_option }
    end

    def create
      @custom_option = CustomOption.new(custom_option_params)
      if @custom_option.save
        render partial: 'show_wrapper', locals: { custom_option: @custom_option }
      else
        render partial: 'new', locals: { custom_option: @custom_option }, status: 409
      end
    end

    def update
      if @custom_option.update_attributes(custom_option_params)
        render partial: 'show', locals: { custom_option: @custom_option }
      else
        render partial: 'edit', locals: { custom_option: @custom_option }, status: 409
      end
    end

    def destroy
      @custom_option.destroy
      head :ok and return
    end

    protected

    def custom_option_params
      params[:custom_option].permit!
    end

    def get_custom_option
      @custom_option = CustomOption.find(params[:id])
    end
  end
end
