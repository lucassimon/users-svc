# frozen_string_literal: true

module V1
  # Blogs API
  class BlogsController < ApplicationController
    before_action :authenticate_request!
    before_action :set_blog, only: %i[show update destroy]

    def index
      @blogs = policy_scope(Blog)
      render json: @blogs, status: :ok
    end

    def show
      authorize @blog
      render json: @blog, status: :ok
    end

    def create
      @blog = Blog.new(blog_params)
      authorize @blog
      @blog.save!
      render json: @blog, status: :created
    end

    def update
      authorize @blog
      @blog.update!(blog_params)
      render json: @blog, status: :ok
    end

    def destroy
      authorize @blog
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
