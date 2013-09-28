require_relative '../spec_helper'

describe Kanpachi::DSL::Response do
  subject do
    Kanpachi::DSL::Response.new(response)
  end

  let(:response) do
    Kanpachi::Response.new(:default)
  end

  it 'sets the status' do
    subject.status 201
    response.status.must_equal 201
  end

  it 'sets the header' do
    subject.header 'Content-Type', 'application/json'
    response.headers['Content-Type'].must_equal 'application/json'
  end

  it 'sets the representation' do
    subject.representation do
      property :id, type: Integer
    end

    id = response.representation.properties['id']
    id.wont_be_nil
    id[:type].must_equal Integer
  end
end
