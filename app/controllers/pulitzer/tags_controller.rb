module Pulitzer
  class TagsController < ApplicationController
    before_action :get_tag, only: [:edit, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index
      @root_tags = Tag.root
      @flat_tags = Tag.flat
      render partial: 'index'
    end

    def new
      @tag = Tag.new(tag_params)
      render partial: new_template(@tag)
    end

    def edit
      render partial: 'form', locals: { tag: @tag }
    end

    def show
      @tag = Tag.find(params[:id])
      render partial: 'show', locals: { tag: @tag }
    end

    def create
      @tag = Tag.new(tag_params)
      if @tag.save
        render partial: 'show_wrapper', locals: { tag: @tag }
      else
        render partial: new_template(@tag), locals: { tag: @tag }, status: 409
      end
    end

    def update
      if @tag.update_attributes(tag_params)
        render partial: 'show', locals: { tag: @tag }
      else
        render partial: 'form', locals: { tag: @tag }, status: 409
      end
    end

    def destroy
      @tag.destroy
      head :ok and return
    end

    protected

    def new_template(tag)
      tag.hierarchical? ? 'new_hierarchical' : 'new_flat'
    end

    def render_not_found(e)
      Rails.logger.warn("Rendering 404 because #{e.inspect}")
      head :ok and return, status: :not_found
    end

    def tag_params
      params[:tag].permit!
    end

    def get_tag
      @tag = Tag.find(params[:id])
    end
  end
end
