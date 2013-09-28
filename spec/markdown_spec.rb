require_relative 'spec_helper'

describe Kanpachi::Markdown do
  subject do
    Kanpachi::Markdown
  end

  it 'converts markdown text to html' do
    text = '_omg_ __blah__ <http://example.org/test>'
    subject.to_html(text).must_equal %Q{<p><em>omg</em> <strong>blah</strong> <a href=\"http://example.org/test\">http://example.org/test</a></p>\n}
  end
end
