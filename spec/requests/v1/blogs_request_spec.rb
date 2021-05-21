# frozen_string_literal: true

require 'swagger_helper'

describe 'V1::Blog', type: :request, swagger_doc: 'v1/swagger.yaml' do
  path '/v1/blogs' do
    post 'Creates a blog' do
      tags 'Blogs'
      consumes 'application/json'
      parameter name: :blog, in: :body, schema: { '$ref' => '#/components/schemas/new_blog' }
      produces 'application/json'

      response '201', 'blog created' do
        schema '$ref' => '#/components/schemas/blog'

        let(:blog) { attributes_for(:blog) }
        run_test!
      end

      response '422', 'invalid request' do
        schema '$ref' => '#/components/schemas/error_object'

        let(:blog) { { title: '' } }
        run_test!
      end
    end

    get 'Get the blogs list' do
      tags 'Blogs'
      produces 'application/json'

      response '200', 'the blogs list' do
        schema type: :array,
               items: {
                 '$ref' => '#/components/schemas/blog'
               }

        let(:blogs) { create_list(:blog, 10) }
        run_test!
      end
    end
  end

  path '/v1/blogs/{id}' do
    get 'Retrieves a blog' do
      tags 'Blogs'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'

      response '200', 'the blog found' do
        schema '$ref' => '#/components/schemas/blog'

        let(:id) { create(:blog).id }
        run_test!
      end

      response '404', 'blog not found' do
        schema '$ref' => '#/components/schemas/error_object'

        let(:id) { 0 }
        run_test!
      end
    end

    put 'Updates a blog' do
      tags 'Blogs'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :blog, in: :body, schema: { '$ref' => '#/components/schemas/new_blog' }
      produces 'application/json'

      let(:id) { create(:blog).id }
      let(:blog) { { title: 'New title' } }

      response '200', 'the updated blog' do
        schema '$ref' => '#/components/schemas/blog'

        run_test!
      end

      response '404', 'blog not found' do
        schema '$ref' => '#/components/schemas/error_object'

        let(:id) { 0 }

        run_test!
      end

      response '422', 'invalid request' do
        schema '$ref' => '#/components/schemas/error_object'

        let(:blog) { { title: '' } }

        run_test!
      end
    end

    delete 'Removes a blog' do
      tags 'Blogs'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'

      let(:id) { create(:blog).id }

      response '204', 'Removes the blog successfuly' do
        run_test!
      end

      response '404', 'blog not found' do
        schema '$ref' => '#/components/schemas/error_object'

        let(:id) { 0 }

        run_test!
      end
    end
  end
end
