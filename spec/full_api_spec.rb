require_relative 'spec_helper'
require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

describe 'Integration Spec' do
  it 'test the entire stack' do
    extend Kanpachi::DSL

    repo = Class.new do
      attr_accessor :title, :id, :users
    end

    user = Class.new do
      attr_accessor :first_name, :last_name
    end

    user_representer = Module.new do
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
      property :first_name, type: String, required: true, doc: "it's the first name"
      property :last_name, type: String, required: true, doc: "it's the last name"
    end

    a = api 'Twitter' do
      title 'API v1.1'
      description 'This describes the resources that make up the official Twitter API v1.1'
      host 'api.twitter.com'

      error :malformed_params do
        description 'Sending invalid JSON will result in a 400 Bad Request response.'

        response do
          status 400
          header 'Content-Type', 'application/json'
          representation do
            property :message, type: String
          end
        end
      end

      section 'Tweets' do
        description 'Tweets are the atomic building blocks of Twitter, 140-character status updates with additional associated metadata. People tweet for a variety of reasons about a multitude of topics.'

        resource :get, '/user/repos' do
          name 'list of repos'
          versions '1.1', '2.0'
          ssl true
          formats :json, :xml

          params do
            required do
              string :title, max_length: 100, nils: false, doc: "test"
              string :gender, in: [:male, :female, :other], doc: "test"
            end

            optional do
              integer :id, min: 0, max: 1024
            end
          end

          response do
            status 200
            header 'Content-Type', 'application/json'
            representation do
              property :id, type: Integer, doc: "it's the id", example: 1
              property :title, type: String, doc: "it's the title", example: 'The Title'
              collection :users, extend: user_representer, doc: "it's the users"
            end
          end

          response :id_list do
            status 200
            header 'Content-Type', 'application/json'
            representation do
              property :id, type: Integer, doc: "it's the id"
            end
          end
        end
      end
    end

    puts a.name
    puts a.title
    puts a.description
    puts a.host
    puts a.sections
    puts "sections"
    a.sections.all.each do |v|
      puts v.name
      puts v.description
      puts v.routes
    end

    puts a.resources

    puts "resources"
    a.resources.to_hash.each do |k, r|
      puts r.http_verb
      puts r.versions.inspect
      puts r.formats.inspect
      puts r.name
      puts r.authentication
      puts r.ssl
      puts r.description
      puts r.params
      puts r.responses
      r.responses.all.first.representation.send :include, Roar::Representer::JSON
      u = user.new
      u.first_name = "Jack"
      u.last_name = "Chu"
      rep = repo.new.extend(r.responses.all.first.representation)
      rep.title = "Hi"
      rep.id = ""
      rep.users = []
      rep.users << u
      puts rep.to_json

      puts rep
      puts r.url
      res = r.responses.all.first
      puts res.representation.representable_attrs.map &:inspect
      puts res.status
      puts res.headers
      puts res.headers['Content-Type']

      v = r.params.run(title: "woohoo", id: 1)
      puts "valid: #{v.success?}"
    end
  end
end
