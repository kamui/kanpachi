require 'kanpachi/dsl/response'

module Kanpachi
  module DSL
    class Resource
      # Constructor
      # @param [Kanpachi::Resource] resource Name of the resource
      #
      # @api public
      def initialize(resource)
        @resource = resource
      end

      # Sets the name
      # @param [String] name Name of the resource
      #
      # @return [String] Name of resource
      # @api public
      def name(name)
        @resource.name = name
      end

      # Sets the description
      # @param [String] description Description of the resource
      #
      # @return [String] Description of resource
      # @api public
      def description(description)
        @resource.description = description
      end

      # Sets the priority
      # @param [Integer] priority Priority of the resource. Usually, the first
      # matching url a request matches will be executed, priority determines the
      # order in which urls are matched. Defaults to 50.
      #
      # @return [String] Name of resource
      # @api public
      def priority(priority)
        @resource.priority = priority
      end

      # Mark that the service requires a SSL connection
      #
      # @param [Boolean] ssl True if the resource requires ssl.
      # @return [Boolean]
      # @api public
      def ssl(ssl)
        @resource.ssl = ssl
      end

      # Mark that the service requires authentication.
      # Note: Authentication is turned off by default
      #
      # @param [Boolean] authentication True if the resource requires authentication.
      # @return [Boolean]
      # @api public
      def authentication(authentication)
        @resource.authentication = authentication
      end

      # Sets or returns the version
      # @param [Set<String>] vers Version of the resource
      #
      # @return [Set<String>] versions supported
      # @api public
      def versions(*vers)
        @resource.versions.merge(vers) unless vers.empty?
      end

      # Sets or returns the supported formats
      # @param [String, Symbol] f_types Format type supported, such as :xml
      #
      # @return [Array<Symbol>] List of supported formats
      # @api public
      def formats(*f_types)
        @resource.formats.merge(f_types) unless f_types.empty?
      end

      # Returns the defined params
      # for DSL use only!
      # To keep the distinction between the request params and the service params
      # using the +defined_params+ accessor is recommended.
      # @see Kanpachi::Params
      #
      # @return [Kanpachi::Params] The defined params
      # @api public
      def params(&block)
        if block_given?
          @resource.params.class_eval &block
        else
          @resource.params
        end
      end

      # Returns the service response
      # @yield The service response object
      #
      # @return [Kanpachi::Response]
      # @api public
      def response(name = :default, &block)
        response = Kanpachi::Response.new(name)
        dsl = Kanpachi::DSL::Response.new(response)
        dsl.instance_eval &block if block_given?
        @resource.responses.add(response)
        response
      end
    end
  end
end
