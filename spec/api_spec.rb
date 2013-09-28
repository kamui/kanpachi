require_relative 'spec_helper'

describe Kanpachi::API do
  subject do
    Kanpachi::API.new('MockApi')
  end

  it 'returns the API name' do
    subject.name.must_equal 'MockApi'
  end

  it 'initializes resources as a Kanpachi::ResourceList' do
    subject.resources.class.must_equal Kanpachi::ResourceList
  end

  it 'initializes errors as a Kanpachi::ErrorList' do
    subject.errors.class.must_equal Kanpachi::ErrorList
  end

  it 'initializes sections as a Kanpachi::SectionList' do
    subject.sections.class.must_equal Kanpachi::SectionList
  end

  it 'has a title' do
    subject.title = 'The Mock API!'
    subject.title.must_equal 'The Mock API!'
  end

  it 'has a description' do
    subject.description = 'API for testing'
    subject.description.must_equal 'API for testing'
  end

  it 'has a host' do
    subject.description = 'API for testing'
    subject.description.must_equal 'API for testing'
  end

  it 'has sections' do
    section = Kanpachi::Section.new('Stuff')
    subject.sections.add(section)
    subject.sections.find('Stuff').must_equal section
  end

  it 'has errors' do
    error = Kanpachi::Error.new(:not_found)
    subject.errors.add(error)
    subject.errors.find(:not_found).must_equal error
  end

  it 'has resources' do
    resource = Kanpachi::Resource.new(:post, '/posts')
    subject.resources.add(resource)
    subject.resources.find(:post, '/posts').must_equal resource
  end
end
