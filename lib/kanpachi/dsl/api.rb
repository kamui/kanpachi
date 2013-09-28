require 'kanpachi/error'
require 'kanpachi/section'
require 'kanpachi/resource'
require 'kanpachi/dsl/error'
require 'kanpachi/dsl/section'
require 'kanpachi/dsl/resource'

module Kanpachi
  module DSL
    class API
      def initialize(api)
        @api = api
      end

      # Sets the title
      # @param [String] title Title of the API
      #
      # @return [String] Title of the API
      # @api public
      def title(title)
        @api.title = title
      end

      # Sets the description
      # @param [String] description Description of the API
      #
      # @return [String] Description of API
      # @api public
      def description(description)
        @api.description = description
      end

      # Sets the host name
      # @param [String] host Host name of the API
      #
      # @return [String] Host name of API
      # @api public
      def host(host)
        @api.host = host
      end

      # Define an error
      # @param [String] name The name of the error.
      # @api public
      def error(name, &block)
        error = Kanpachi::Error.new(name)
        dsl = Error.new(error, self)
        dsl.instance_eval &block if block_given?
        @api.errors.add(error)
      end


      # Define a section
      # @param [String] name The name of the section.
      # @api public
      def section(name, &block)
        section = @api.sections.find(name) || Kanpachi::Section.new(name)
        dsl = Section.new(section, self)
        dsl.instance_eval &block if block_given?
        @api.sections.add(section)
      end

      # Define a resource
      #
      # @param [Symbol] http_verb The http verb of the resource.
      # @param [String] url The url of the resource.
      # @yield [Kanpachi] The newly created service.
      # @return [Kanpachi::Resource] The resource already defined
      # @example Describing a basic service
      #   resource :get, "/hello_world" do |service|
      #     # describe the resource
      #   end
      #
      # @api public
      def resource(http_verb, url, &block)
        resource = Kanpachi::Resource.new(http_verb, url)
        dsl = Resource.new(resource)
        if block_given?
          if block.arity == 1
            yield dsl
          else
            dsl.instance_eval &block
          end
        end
        @api.resources.add(resource)
        resource
      end
    end
  end
end