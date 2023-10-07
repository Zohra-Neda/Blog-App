require 'swagger_helper'

RSpec.describe 'api/blogs', type: :request do
  path '/api/v1/posts' do
    post 'Creates a post' do
      tags 'Posts'
      consumes 'application/json', 'application/xml'
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer },
          author_id: { type: :integer },
          title: { type: :string },
          text: { type: :string }
        },
        required: %w[id author_id title text]
      }

      response '201', 'post created' do
        let(:post) { { id: 1, author_id: 1, title: 'Ruby on Rails', text: 'awesome' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:post) { { text: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/posts/{id}/comments' do
    get 'Retrieves a comment' do
      tags 'Comments'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'name found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 author_id: { type: :integer },
                 post_id: { type: :integer },
                 text: { type: :string }
               },
               required: %w[id author_id post_id text]

        let(:id) { Comment.create(text: 'foo', post_id: 1, author_id: 1).id }
        run_test!
      end

      response '404', 'comment not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
