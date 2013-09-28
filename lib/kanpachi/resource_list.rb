module Kanpachi
  # Class to keep track of all defined resources
  #
  # @api public
  class ResourceList
    class UnknownResource < StandardError; end
    class DuplicateResource < StandardError; end

    def initialize
      @list = {}
    end

    # Returns a hash of resources
    #
    # @return [Hash<Kanpachi::Resource>] All the added resources.
    # @api public
    def to_hash
      @list
    end

    # Returns an array of resources
    #
    # @return [Array<Kanpachi::Resource>] List of added resources.
    # @api public
    def all
      @list.values
    end

    # Add a resource to the list
    #
    # @param [Kanpachi::Resource] The resource to add.
    # @return [Hash<Kanpachi::Resource>] All the added resources.
    # @raise DuplicateResource If a resource is being duplicated.
    # @api public
    def add(resource)
      if @list.key? resource.route
        raise DuplicateResource, "A resource accessible via #{resource.http_verb} #{resource.url} already exists"
      end
      @list[resource.route] = resource
    end

    # Returns a resource based on its name
    #
    # @param [String] name The name of the resource you are looking for.
    # @raise [UnknownResource] if a resource with the passed name isn't found.
    # @return [Kanpachi::Resource] The found resource.
    #
    # @api public
    def named(name)
      resource = all.detect { |resource| resource.name == name }
      if resource.nil?
        raise UnknownResource, "Resource named #{name} doesn't exist"
      else
        resource
      end
    end

    # Returns a resource based on its verb and url
    #
    # @param [String] verb The request method (GET, POST, PUT, DELETE)
    # @param [String] url The url of the resource you are looking for.
    # @return [Nil, Kanpachi::Resource] The found resource.
    #
    # @api public
    def find(verb, url)
      http_verb = verb.to_s.upcase
      route = "#{http_verb} #{url}"
      @list[route]
    end
  end
end
