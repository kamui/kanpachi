module Kanpachi
  # Class to keep track of all defined responses
  #
  # @api public
  class ResponseList
    class DuplicateResponse < StandardError; end

    def initialize
      @list = {}
    end

    # Returns a hash of responses
    #
    # @return [Hash<Kanpachi::Response>] All the added responses.
    # @api public
    def to_hash
      @list
    end

    # Returns an array of responses
    #
    # @return [Array<Kanpachi::Response>] List of added responses.
    # @api public
    def all
      @list.values
    end

    # Add a response to the list
    #
    # @param [Kanpachi::Response] response The response to add.
    # @return [Hash<Kanpachi::Response>] All the added responses.
    # @raise DuplicateResponse If a response is being duplicated.
    # @api public
    def add(response)
      if @list.key? response.name
        raise DuplicateResponse, "A response named #{response.name} already exists"
      end
      @list[response.name] = response
    end

    # Returns a response based on its verb and url
    #
    # @param [String] name The name of the response you are looking for.
    # @return [Nil, Kanpachi::Response] The found response.
    #
    # @api public
    def find(name)
      @list[name]
    end
  end
end
