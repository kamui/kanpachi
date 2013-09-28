module Kanpachi
  module DSL
    class Error
      # Constructor
      # @param [Kanpachi::Error] error Name of the error
      #
      # @api public
      def initialize(error, api_dsl)
        @error = error
        @api_dsl = api_dsl
      end

      # Sets the description
      # @param [String] description Description of the error
      #
      # @return [String] Description of error
      # @api public
      def description(description)
        @error.description = description
      end

      # Returns the error
      # @yield The error object
      #
      # @return [Kanpachi::Response]
      # @api public
      def response(&block)
        dsl = Response.new(@error.response)
        if block_given?
          dsl.instance_eval &block
        else
          @error.response
        end
      end
    end
  end
end
