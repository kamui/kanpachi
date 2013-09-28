require_relative 'spec_helper'

describe Kanpachi::SectionList do
  subject do
    Kanpachi::SectionList.new
  end

  let(:users_section) do
    Kanpachi::Section.new('Users')
  end

  let(:populated_section_list) do
    list = Kanpachi::SectionList.new
    list.add(users_section)
    list
  end

  it 'initializes empty' do
    subject.all.must_be_empty
  end

  it 'returns a hash of the internal list, with section names as the key and a Section object as the value' do
    populated_section_list.to_hash.keys.must_include 'Users'
    populated_section_list.to_hash['Users'].must_equal users_section
  end

  it 'returns an array of Section objects' do
    populated_section_list.all.must_include users_section
  end

  it 'adds a section' do
    subject.add(users_section)
    subject.all.must_include users_section
  end

  it 'finds a section by name' do
    populated_section_list.find('Users').must_equal users_section
  end
end
