module Pulitzer
  class CustomOptionListsController < ApplicationController
    before_action :get_custom_option_list, except: [:index,:new, :create]

    def index
      @custom_option_lists = CustomOptionList.all
      render_ajax
    end

    def new
      @custom_option_list = CustomOptionList.new(custom_option_list_params)
      render_ajax locals: { custom_option_list: @custom_option_list }
    end

    def edit
      render_ajax locals: { custom_option_list: @custom_option_list }
    end

    def show
      render_ajax locals: { custom_option_list: @custom_option_list }
    end

    def create
      @custom_option_list = CustomOptionList.new(custom_option_list_params)
      if @custom_option_list.save
        render partial: 'show_wrapper', locals: { custom_option_list: @custom_option_list }
      else
        render partial: 'new', locals: { custom_option_list: @custom_option_list }, status: 409
      end
    end

    def update
      if @custom_option_list.update_attributes(custom_option_list_params)
        render partial: 'show', locals: { custom_option_list: @custom_option_list }
      else
        render partial: 'edit', locals: { custom_option_list: @custom_option_list }, status: 409
      end
    end

    def destroy
      @custom_option_list.destroy
      head :ok and return
    end

    protected

    def custom_option_list_params
      params[:custom_option_list].permit!
    end

    def get_custom_option_list
      @custom_option_list = CustomOptionList.find(params[:id])
    end
  end
end
