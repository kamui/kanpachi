module Kanpachi
  # Class to keep track of all defined sections
  #
  # @api public
  class SectionList
    def initialize
      @list = {}
    end

    # Returns a hash of sections
    #
    # @return [Hash<Kanpachi::Section>] All the added sections.
    # @api public
    def to_hash
      @list
    end

    # Returns an array of sections
    #
    # @return [Array<Kanpachi::Section>] List of added sections.
    # @api public
    def all
      @list.values
    end

    # Add a section to the list
    #
    # @param [Kanpachi::Section] section The section to add.
    # @return [Hash<Kanpachi::Section>] All the added sections.
    # @api public
    def add(section)
      @list[section.name] = section
    end

    # Returns a section based on its verb and url
    #
    # @param [String] verb The request method (GET, POST, PUT, DELETE)
    # @param [String] url The url of the section you are looking for.
    # @return [Nil, Kanpachi::Section] The found section.
    #
    # @api public
    def find(name)
      @list[name]
    end
  end
end
