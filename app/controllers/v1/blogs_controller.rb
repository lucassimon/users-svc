# frozen_string_literal: true

module V1
  # Blogs API
  class BlogsController < ApplicationController
    before_action :authenticate_request!
    before_action :set_blog, only: %i[show update destroy]

    def index
      @blogs = Blog.all
      render json: @blogs, status: :ok
    end

    def show
      render json: @blog, status: :ok
    end

    def create
      @blog = Blog.create!(blog_params)
      render json: @blog, status: :created
    end

    def update
      @blog.update!(blog_params)
      render json: @blog, status: :ok
    end

    def destroy
      @blog.destroy!
      head :no_content
    end

    private

    def blog_params
      params.require(:blog).permit(:title, :author_id)
    end

    def set_blog
      @blog = Blog.find(params[:id])
    end
  end
end
