require_relative 'spec_helper'

describe Kanpachi::ResourceList do
  subject do
    Kanpachi::ResourceList.new
  end

  let(:login_resource) do
    Kanpachi::Resource.new(:post, '/login').tap do |r|
      r.name = 'login'
    end
  end

  let(:populated_resource_list) do
    list = Kanpachi::ResourceList.new
    list.add(login_resource)
    list
  end

  it 'initializes empty' do
    subject.all.must_be_empty
  end

  it 'returns a hash of the internal list, with resource names as the key and a Resource object as the value' do
    populated_resource_list.to_hash.keys.must_include login_resource.route
    populated_resource_list.to_hash[login_resource.route].must_equal login_resource
  end

  it 'returns an array of Resource objects' do
    populated_resource_list.all.must_include login_resource
  end

  it 'adds a resource' do
    subject.add(login_resource)
    subject.all.must_include login_resource
  end

  it 'raises DuplicateResource if adding an Resource with a name that already exists' do
    proc { populated_resource_list.add(login_resource) }.must_raise Kanpachi::ResourceList::DuplicateResource
  end

  it 'finds a resource by http verb and url' do
    populated_resource_list.find(:post, '/login').must_equal login_resource
  end

  it 'finds a resource by name' do
    populated_resource_list.named('login').must_equal login_resource
  end

  it 'raises UnknownResource if resource not found by name' do
    proc { populated_resource_list.named('logout') }.must_raise Kanpachi::ResourceList::UnknownResource
  end
end
