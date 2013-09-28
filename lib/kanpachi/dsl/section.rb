module Kanpachi
  module DSL
    class Section
      # Constructor
      # @param [Kanpachi::Section] section Name of the section
      #
      # @api public
      def initialize(section, api_dsl)
        @section = section
        @api_dsl = api_dsl
      end

      # Sets the description
      # @param [String] description Description of the section
      #
      # @return [String] Description of section
      # @api public
      def description(description)
        @section.description = description
      end

      def resource(*attrs, &block)
        res = @api_dsl.resource(*attrs, &block)
        @section.routes << [res.http_verb, res.url]
        res
      end
    end
  end
end
