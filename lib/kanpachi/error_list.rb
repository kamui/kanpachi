module Kanpachi
  # Class to keep track of all defined errors
  #
  # @api public
  class ErrorList
    class DuplicateError < StandardError; end

    def initialize
      @list = {}
    end

    # Returns a hash of errors
    #
    # @return [Hash<Kanpachi::Error>] All the added errors.
    # @api public
    def to_hash
      @list
    end

    # Returns an array of errors
    #
    # @return [Array<Kanpachi::Error>] List of added errors.
    # @api public
    def all
      @list.values
    end

    # Add a error to the list
    #
    # @param [Kanpachi::Error] error The error to add.
    # @return [Hash<Kanpachi::Error>] All the added errors.
    # @raise DuplicateError If a error is being duplicated.
    # @api public
    def add(error)
      if @list.key? error.name
        raise DuplicateError, "An error named #{error.name} already exists"
      end
      @list[error.name] = error
    end

    # Returns a error based on its verb and url
    #
    # @param [String] name The name of the error
    # @return [Nil, Kanpachi::Error] The found error.
    #
    # @api public
    def find(name)
      @list[name]
    end
  end
end
