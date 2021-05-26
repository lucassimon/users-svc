# frozen_string_literal: true

require 'swagger_helper'

describe 'V1::Blog', type: :request, swagger_doc: 'v1/swagger.yaml' do
  path '/v1/blogs' do
    post 'Creates a blog' do
      tags 'Blogs'
      consumes 'application/json'
      parameter name: :blog, in: :body, schema: { '$ref' => '#/components/schemas/new_blog' }
      produces 'application/json'
      security [bearer_auth: []]

      include_context 'with jwt authentication'
      let(:blog) { attributes_for(:blog, author_id: user_id) }

      response '201', 'blog created' do
        schema '$ref' => '#/components/schemas/blog'
        run_test!
      end

      response '401', 'Not authenticated' do
        schema '$ref' => '#/components/schemas/error_object'
        include_context 'with missing jwt authentication'
        run_test!
      end

      response '403', 'Not authorized' do
        schema '$ref' => '#/components/schemas/error_object'
        let(:blog) { attributes_for(:blog) }
        run_test!
      end

      response '422', 'invalid request' do
        schema '$ref' => '#/components/schemas/error_object'
        let(:blog) { { title: '', author_id: user_id } }
        run_test!
      end
    end

    get 'Get the blogs list' do
      tags 'Blogs'
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'the blogs list' do
        schema type: :array,
               items: {
                 '$ref' => '#/components/schemas/blog'
               }

        include_context 'with jwt authentication'
        before do
          create_list(:blog, 5)
          create_list(:blog, 5, author_id: user_id)
        end

        run_test! do
          expect(json_response.size).to eq(5)
          expect(json_response.first.author_id).to eq(user_id)
        end
      end

      response '401', 'Not authenticated' do
        schema '$ref' => '#/components/schemas/error_object'
        include_context 'with missing jwt authentication'
        run_test!
      end
    end
  end

  path '/v1/blogs/{id}' do
    get 'Retrieves a blog' do
      tags 'Blogs'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'
      security [bearer_auth: []]

      include_context 'with jwt authentication'
      let(:id) { create(:blog, author_id: user_id).id }

      response '200', 'the blog found' do
        schema '$ref' => '#/components/schemas/blog'
        run_test!
      end

      response '401', 'Not authenticated' do
        schema '$ref' => '#/components/schemas/error_object'
        include_context 'with missing jwt authentication'
        run_test!
      end

      response '403', 'Not authorized' do
        schema '$ref' => '#/components/schemas/error_object'
        let(:id) { create(:blog).id }
        run_test!
      end

      response '404', 'blog not found' do
        schema '$ref' => '#/components/schemas/error_object'
        include_context 'with jwt authentication'

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
      security [bearer_auth: []]

      include_context 'with jwt authentication'
      let(:id) { create(:blog, author_id: user_id).id }
      let(:blog) { { title: 'New title' } }

      response '200', 'the updated blog' do
        schema '$ref' => '#/components/schemas/blog'
        run_test!
      end

      response '401', 'Not authenticated' do
        schema '$ref' => '#/components/schemas/error_object'
        include_context 'with missing jwt authentication'
        run_test!
      end

      response '403', 'Not authorized' do
        schema '$ref' => '#/components/schemas/error_object'
        let(:id) { create(:blog).id }
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
      security [bearer_auth: []]

      include_context 'with jwt authentication'
      let(:id) { create(:blog, author_id: user_id).id }

      response '204', 'Removes the blog successfuly' do
        run_test!
      end

      response '401', 'Not authorized' do
        schema '$ref' => '#/components/schemas/error_object'
        include_context 'with missing jwt authentication'
        run_test!
      end

      response '403', 'Not authorized' do
        schema '$ref' => '#/components/schemas/error_object'
        let(:id) { create(:blog).id }
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
