require_relative '../spec_helper'

describe Kanpachi::DSL::Resource do
  before do
    Kanpachi::APIList.clear
  end

  subject do
    Kanpachi::DSL::Resource.new(users_resource)
  end

  let(:users_resource) do
    Kanpachi::Resource.new(:post, '/users')
  end

  it 'sets the name' do
    subject.name 'MyAPI'
    users_resource.name.must_equal 'MyAPI'
  end

  it 'sets the description' do
    subject.description 'Just for testing'
    users_resource.description.must_equal 'Just for testing'
  end

  it 'sets the priority' do
    subject.priority 999
    users_resource.priority.must_equal 999
  end

  it 'sets ssl' do
    subject.ssl true
    users_resource.ssl.must_equal true
  end

  it 'sets authentication' do
    subject.authentication true
    users_resource.authentication.must_equal true
  end

  it 'sets versions' do
    subject.versions '1.0', '1.1'
    users_resource.versions.must_include '1.0'
    users_resource.versions.must_include '1.1'
  end

  it 'sets formats' do
    subject.formats :xml, :json
    users_resource.formats.must_include :xml
    users_resource.formats.must_include :json
  end

  it 'sets the response' do
    subject.response do
      status 200
    end
    users_resource.responses.find(:default).wont_be_nil
    users_resource.responses.find(:default).status.must_equal 200
  end

  it 'sets the response with an explicit name' do
    subject.response :created do
      status 201
    end
    users_resource.responses.find(:created).wont_be_nil
    users_resource.responses.find(:created).status.must_equal 201
  end

  it 'sets the params' do
    subject.params do
      required do
        integer :id
      end
    end
    users_resource.params?.must_equal true
  end
end
