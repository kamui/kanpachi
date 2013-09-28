module Kanpachi
  class BaseHash
    class UnknownKey < StandardError; end
    class DuplicateKey < StandardError; end

    def initialize
      @hash = {}
    end

    # Returns a hash of hash
    #
    # @return [Hash<Object>] Internal hash.
    # @api public
    def all
      @hash
    end

    # Add a resource to the list
    #
    # @param [Object] The resource to add.
    # @return [Hash<Object>] Internal hash.
    # @raise DuplicateKey If a resource is being duplicated.
    # @api public
    def add(key, value)
      if @hash.key?(attr_key)
        raise DuplicateKey, 'The key #{attr_key} already exists'
      end
      @hash[key] = value
    end

    # Returns value based on its key
    #
    # @param [String, Symbol] key The key of the value you are looking for.
    # @return [Object] The value returned from the hash.
    #
    # @api public
    def find(key)
      all[key]
    end
  end
end
