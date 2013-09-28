require 'kanpachi/response'

module Kanpachi
  class Error
    attr_reader :name
    attr_accessor :description
    attr_accessor :response

    def initialize(name)
      @name = name
      @response = Response.new(:default)
    end
  end
end