require_relative 'spec_helper'

describe Kanpachi::Section do
  subject do
    Kanpachi::Section.new('Posts')
  end

  it 'initialized with the name' do
    subject.name.must_equal 'Posts'
  end

  it 'initialized with a routes array' do
    subject.routes.must_equal []
  end

  it 'has a description accessor' do
    subject.description = 'List all the posts'
    subject.description.must_equal 'List all the posts'
  end
end
