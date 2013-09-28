require_relative 'spec_helper'

describe Kanpachi::Resource do
  describe 'initialized resource' do
    subject do
      Kanpachi::Resource.new(:get, '/test-me')
    end

    let(:params) do
      Class.new(Kanpachi::Resource::Params) do
        required do
          integer :id
        end

        optional do
          string :name
        end
      end
    end

    let(:required_params) do
      Class.new(Kanpachi::Resource::Params) do
        required do
          integer :id
        end
      end
    end

    let(:optional_params) do
      Class.new(Kanpachi::Resource::Params) do
        optional do
          string :id
        end
      end
    end

    it 'returns the http verb' do
      subject.http_verb.must_equal :get
    end

    it 'returns the url' do
      subject.url.must_equal '/test-me'
    end

    it 'returns the params' do
      subject.params = params
      subject.params.ancestors.must_include Kanpachi::Resource::Params
    end

    it 'returns the response list' do
      responses = subject.responses
      responses.must_be_instance_of Kanpachi::ResponseList
      responses.all.must_be_empty
    end

    it 'initializes formats as an empty set' do
      subject.formats.must_equal Set.new
    end

    it 'initializes versions as an empty set' do
      subject.versions.must_equal Set.new
    end

    it 'initializes priority to 50' do
      subject.priority.must_equal 50
    end

    it 'initializes ssl to false' do
      subject.ssl.must_equal false
    end

    it 'initializes authentication to false' do
      subject.authentication.must_equal false
    end

    it 'has a description accessor' do
      subject.description = 'This resource tests me.'
      subject.description.must_equal 'This resource tests me.'
    end

    it 'has a name accessor' do
      subject.name = :test_me
      subject.name.must_equal :test_me
    end

    it 'has a priority accessor' do
      subject.priority = 100
      subject.priority.must_equal 100
    end

    it 'has a ssl accessor' do
      subject.ssl = true
      subject.ssl.must_equal true
    end

    it 'has an authentication accessor' do
      subject.authentication = true
      subject.authentication.must_equal true
    end

    it 'has a versions accessor' do
      subject.versions << '1.1'
      subject.versions.must_include '1.1'
    end

    it 'has a formats accessor' do
      subject.formats << :xml
      subject.formats.must_include :xml
    end

    it 'has a params accessor' do
      subject.params = params
      subject.params.must_equal params
    end

    it 'returns true if the resource has defined any params' do
      subject.params?.must_equal false
      subject.params = required_params
      subject.params?.must_equal true
      subject.params = optional_params
      subject.params?.must_equal true
    end

    it 'returns the route' do
      subject.route.must_equal 'GET /test-me'
    end

    it 'sorts based on priority' do
      middle = subject
      lower = Kanpachi::Resource.new(:get, '/lower')
      lower.priority = -100
      higher = Kanpachi::Resource.new(:get, '/lower')
      higher.priority = 100
      [middle, lower, higher].sort.must_equal [lower, middle, higher]
    end
  end

  it 'ensures the url is prefixed with a slash' do
    resource = Kanpachi::Resource.new(:get, '/has-slash')
    resource.url.must_equal '/has-slash'
    resource = Kanpachi::Resource.new(:get, 'missing-slash')
    resource.url.must_equal '/missing-slash'
  end
end
