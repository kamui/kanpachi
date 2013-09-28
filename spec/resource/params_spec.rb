require_relative '../spec_helper'

describe Kanpachi::Resource::Params do
  subject do
    Kanpachi::Resource::Params
  end

  it 'is a kind of Mutations::Command' do
    subject.superclass.must_equal Mutations::Command
  end
end
