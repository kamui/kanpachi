require_relative '../spec_helper'

describe Kanpachi::DSL::Error do
  before do
    Kanpachi::APIList.clear
  end

  subject do
    Kanpachi::DSL::Error.new(not_found_error, api_dsl)
  end

  let(:not_found_error) do
    Kanpachi::Error.new(:not_found_error)
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

  it 'sets the description' do
    subject.description 'Just for testing'
    not_found_error.description.must_equal 'Just for testing'
  end

  it 'sets the response' do
    subject.response do
      status 201
    end
    not_found_error.response.status.must_equal 201
  end
end
