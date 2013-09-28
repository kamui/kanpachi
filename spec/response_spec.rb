require_relative 'spec_helper'

describe Kanpachi::Response do
  subject do
    Kanpachi::Response.new(:default)
  end

  it 'initializes with the status' do
    subject.status.must_equal 200
  end

  it 'initializes with a headers hash' do
    subject.headers.must_equal Hash.new
  end

  it 'returns headers' do
    subject.headers['Content-Type'] = 'application/json'
    subject.headers.keys.must_include 'Content-Type'
  end

  it 'has a representation accessor' do
    representation = Module.new do
      include Kanpachi::Response::Representation
      property :title
    end
    subject.representation = representation
    subject.representation.must_equal representation
  end

  it 'representation is a Roar representer' do
    subject.representation.ancestors.must_include Roar::Representer
    subject.representation.ancestors.must_include Roar::Representer::Feature::Hypermedia
  end

  it 'representation returns properties' do
    user_representer = Module.new do
      include Kanpachi::Response::Representation
      property :name, type: String
      property :email, type: String
    end

    representation = Module.new do
      include Kanpachi::Response::Representation
      property :id, type: Integer
      collection :people, extend: user_representer
      hash :user, extend: user_representer
    end
    representation.properties.keys.must_include 'id'
    representation.properties.keys.must_include 'people'
    representation.properties.keys.must_include 'user'
    representation.properties['id'][:type].must_equal Integer
    representation.properties['people'][:collection].must_equal true
    representation.properties['people'][:default].must_be_empty
    representation.properties['people']['name'][:type].must_equal String
    representation.properties['people']['email'][:type].must_equal String
  end
end
