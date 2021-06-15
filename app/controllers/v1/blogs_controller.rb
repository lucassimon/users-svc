# frozen_string_literal: true


module V1
  # Blogs API
  class BlogsController < ApplicationController
    # before_action :authenticate_request!
    before_action :set_blog, only: %i[show update destroy]

    def password_recovery
      # @blogs = policy_scope(Blog)
      session = Kratos::Session.new
      payload = { schema_id: 'default', "password": "foo_bar_123", traits: { 'email' => 'teste20@gmail.com' }}
      response = session.register(payload)
      
      render json: response, status: :ok
    end

    def index
      # TODO: get the email from request.body

      # TODO: Get the email first in database
      
      # TODO: Send though kratos the recovery 
      session = Kratos::Session.new
      payload = { 'email' => 'teste20@gmail.com' }
      response = session.password_recovery(payload)

      render json: response, status: :ok

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
