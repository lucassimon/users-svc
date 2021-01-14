# frozen_string_literal: true

module V1
  # Blogs API
  class BlogsController < ApplicationController
    before_action :set_blog, only: %i[show]

    def show
      render json: @blog, status: :ok
    end

    def create
      @blog = Blog.create!(blog_params)
      render json: @blog, status: :created
    end

    private

    def blog_params
      params.required(:blog).permit(:title, :content)
    end

    def set_blog
      @blog = Blog.find(params[:id])
    end
  end
end
