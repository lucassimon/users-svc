# frozen_string_literal: true

require 'swagger_helper'

describe 'V1::Blog', type: :request, swagger_doc: 'v1/swagger.yaml' do
  path '/v1/blogs' do
    post 'Creates a blog' do
      tags 'Blogs'
      consumes 'application/json'
      parameter name: :blog, in: :body, schema: { '$ref' => '#components/schemas/new_blog' }
      response '201', 'blog created' do
        schema '$ref' => '#components/schemas/blog'

        let(:blog) { attributes_for(:blog) }
        run_test!
      end

      response '422', 'invalid request' do
        schema '$ref' => '#components/schemas/error_object'

        let(:blog) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/v1/blogs/{id}' do
    get 'Retrieves a blog' do
      tags 'Blogs'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'blog found' do
        schema '$ref' => '#components/schemas/blog'

        let(:id) { create(:blog).id }
        run_test!
      end

      response '404', 'blog not found' do
        schema '$ref' => '#components/schemas/error_object'

        let(:id) { 0 }
        run_test!
      end
    end
  end
end
