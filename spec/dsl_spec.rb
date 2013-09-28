require_relative 'spec_helper'

describe Kanpachi::DSL do
  describe 'extend self with Kanpachi::DSL' do
    before do
      extend Kanpachi::DSL
      @api = api 'MyApp' do
        title 'My App'
      end
      @before_api_count = Kanpachi::APIList.all.size
    end

    it 'defining an API returns that API' do
      @api.must_be_instance_of Kanpachi::API
    end

    it 'defining a new API adds it to the APIList' do
      your_api = api 'YourApp' do
      end
      Kanpachi::APIList.find('YourApp').must_equal your_api
      Kanpachi::APIList.all.size.must_equal @before_api_count + 1
    end

    it 'defining a existing API does not add it to the APIList' do
      same_api = api 'MyApp' do
      end
      Kanpachi::APIList.find('MyApp').must_equal @api
      Kanpachi::APIList.all.size.must_equal @before_api_count
    end

    it 'defining a existing api reopens that API' do
      same_api = api 'MyApp' do
        title 'An App'
      end
      Kanpachi::APIList.find('MyApp').title.must_equal 'An App'
    end
  end

  it '#api is only available from within self' do
    proc do
      api 'Test' do
        title 'Test'
      end
    end.must_raise NoMethodError
  end
end
