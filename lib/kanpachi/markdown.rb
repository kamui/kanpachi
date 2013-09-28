require 'kramdown'

module Kanpachi
  module Markdown
    module_function

    def to_html(text)
      Kramdown::Document.new(text).to_html
    end
  end
end
