require 'representable/json/collection'

api 'MyAPI' do
  section 'Posts' do
    resource :get, '/posts' do
      name 'List Posts'
      description <<-TEXT
Return a collection of __blog posts__. Sort order defaults to _most recently published_.
TEXT
      versions '1.0'
      ssl true
      formats :json

      params do
        optional do
          integer :size, max: 100, doc: 'The number of results to return. (max: 100)', example: 10
        end
      end

      response do
        status 200
        header 'Content-Type', 'application/json'
        representation do
          include Representable::JSON::Collection
          property :title, type: String, doc: 'Title of the post', example: 'APIs Run Amok!'
          property :body, type: String, doc: 'The Body of the post ', example: 'I love me some API!'
          property :created_at, type: DateTime, doc: 'When the post was created.'
        end
      end
    end
  end
end
