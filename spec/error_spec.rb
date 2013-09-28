require_relative 'spec_helper'

describe Kanpachi::Error do
  subject do
    Kanpachi::Error.new(:not_found).tap do |e|
      e.description = 'Error'
      e.response = Kanpachi::Response.new(:default).tap do |r|
        r.status = 404
      end
    end
  end

  it 'initialized with the name' do
    subject.name.must_equal :not_found
  end

  it 'initialized with a Response with the name :default' do
    subject.response.must_be_instance_of Kanpachi::Response
    subject.response.name.must_equal :default
  end

  it 'has a description accessor' do
    subject.description = 'Error returned with resource is not found'
    subject.description.must_equal 'Error returned with resource is not found'
  end

  it 'has a response accessor' do
    response = Kanpachi::Response.new(:bad_request).tap do |r|
      r.status = 400
    end
    subject.response = response
    subject.response.must_equal response
  end
end
