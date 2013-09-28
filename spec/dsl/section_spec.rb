require_relative '../spec_helper'

describe Kanpachi::DSL::Section do
  before do
    Kanpachi::APIList.clear
  end

  subject do
    Kanpachi::DSL::Section.new(users_section, api_dsl)
  end

  let(:api_dsl) do
    Kanpachi::DSL::API.new(my_api)
  end

  let(:my_api) do
    extend Kanpachi::DSL
    api 'MyApp' do
      title 'My App'
    end
  end

  let(:users_section) do
    Kanpachi::Section.new('Users')
  end

  it 'sets the description' do
    subject.description 'Just for testing'
    users_section.description.must_equal 'Just for testing'
  end

  it 'adds a new resource to the resource list' do
    resource = subject.resource :get, '/posts'
    route = [resource.http_verb, resource.url]
    users_section.routes.must_include route
    my_api.resources.find(*route).must_equal resource
  end

  it 'raises a Kanpachi::ResourceList::DuplicateResource if resource route already exists' do
    subject.resource :get, '/users'
    proc do
      subject.resource :get, '/users' do
        response do
          status 400
        end
      end
    end.must_raise Kanpachi::ResourceList::DuplicateResource
  end
end
