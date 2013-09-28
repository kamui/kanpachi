require_relative 'spec_helper'

describe Kanpachi::APIList do
  before do
    Kanpachi::APIList.clear
  end

  subject do
    Kanpachi::APIList
  end

  it 'initializes empty' do
    subject.all.must_be_empty
  end

  describe 'Populated API' do
    let(:myapp_api) do
      Kanpachi::API.new('MyApp')
    end

    it 'returns a hash of the internal list, with API names as the key and a Section object as the value' do
      Kanpachi::APIList.add(myapp_api)
      subject.to_hash.keys.must_include 'MyApp'
      subject.to_hash['MyApp'].must_equal myapp_api
    end

    it 'returns an array of Section objects' do
      Kanpachi::APIList.add(myapp_api)
      subject.all.must_include myapp_api
    end

    it 'adds a API' do
      subject.add(myapp_api)
      subject.all.must_include myapp_api
    end

    it 'finds a API by name' do
      Kanpachi::APIList.add(myapp_api)
      subject.find('MyApp').must_equal myapp_api
    end
  end

  it 'clears all APIs' do
    myapp_api = Kanpachi::API.new('MyApp')
    Kanpachi::APIList.add(myapp_api)
    subject.clear
    subject.all.size.must_equal 0
  end
end
