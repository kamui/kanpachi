require 'kanpachi/error_list'
require 'kanpachi/section_list'
require 'kanpachi/resource_list'

module Kanpachi
  class API
    attr_reader :name
    attr_reader :errors
    attr_reader :sections
    attr_reader :resources
    attr_accessor :title
    attr_accessor :description
    attr_accessor :host

    def initialize(name)
      @name = name
      @errors = ErrorList.new
      @sections = SectionList.new
      @resources = ResourceList.new
    end
  end
end
