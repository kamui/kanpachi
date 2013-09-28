require_relative 'spec_helper'

describe Kanpachi::ErrorList do
  subject do
    Kanpachi::ErrorList.new
  end

  let(:not_found_error) do
    Kanpachi::Error.new(:not_found)
  end

  let(:populated_error_list) do
    list = Kanpachi::ErrorList.new
    list.add(not_found_error)
    list
  end

  it 'initializes empty' do
    subject.all.must_be_empty
  end

  it 'returns a hash of the internal list, with error names as the key and a Error object as the value' do
    populated_error_list.to_hash.keys.must_include :not_found
    populated_error_list.to_hash[:not_found].must_equal not_found_error
  end

  it 'returns an array of Error objects' do
    populated_error_list.all.must_include not_found_error
  end

  it 'adds a error' do
    subject.add(not_found_error)
    subject.all.must_include not_found_error
  end

  it 'raises DuplicateError if adding an Error with a name that already exists' do
    proc { populated_error_list.add(not_found_error) }.must_raise Kanpachi::ErrorList::DuplicateError
  end

  it 'finds a error by name' do
    populated_error_list.find(:not_found).must_equal not_found_error
  end
end
