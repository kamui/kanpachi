require_relative '../spec_helper'

describe Kanpachi::DSL::API do
  subject do
    Kanpachi::DSL::API.new(my_api)
  end

  let(:my_api) do
    extend Kanpachi::DSL
    api 'MyApp' do
      title 'My App'
    end
  end

  it 'sets the title' do
    subject.title 'My Little API'
    my_api.title.must_equal 'My Little API'
  end

  it 'sets the description' do
    subject.description 'Just for testing'
    my_api.description.must_equal 'Just for testing'
  end

  it 'sets the host' do
    subject.host 'api.localhost.dev'
    my_api.host.must_equal 'api.localhost.dev'
  end

  it 'adds a new error to the error list' do
    error = subject.error :not_authorized
    my_api.errors.find(:not_authorized).must_equal error
  end

  it 'raises a Kanpachi::ErrorList::DuplicateError if error name already exists' do
    subject.error :not_found
    proc do
      subject.error :not_found do
        response do
          status 400
        end
      end
    end.must_raise Kanpachi::ErrorList::DuplicateError
  end

  it 'adds a new section to the section list' do
    subject.section 'Posts'
    my_api.sections.find('Posts').name.must_equal 'Posts'
  end

  it 'reopens a section with the same name in the section list' do
    subject.section 'Users'
    section = subject.section 'Users' do
      description 'Users Section'
    end
    my_api.sections.find('Users').must_equal section
  end

  it 'adds a new resource to the resource list' do
    resource = subject.resource :get, '/posts'
    my_api.resources.find(:get, '/posts').must_equal resource
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
