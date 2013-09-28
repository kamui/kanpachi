module Kanpachi
  module DSL
    class Response
      def initialize(response)
        @response = response
      end

      def status(status)
        @response.status = status
      end

      def header(key, value)
        @response.headers[key] = value
      end

      def representation(&block)
        @response.representation.module_eval &block
      end
    end
  end
end
