module Kanpachi
  # Class for section data.
  #
  # @api public
  class Section
    attr_reader :name
    attr_reader :routes
    attr_accessor :description

    def initialize(name)
      @name = name
      @routes = []
    end
  end
end
