require 'set'
require 'kanpachi/resource/params'
require 'kanpachi/response_list'

module Kanpachi
  # The Resource class
  #
  # @api public
  class Resource
    attr_reader :http_verb
    attr_reader :url
    attr_reader :formats
    attr_reader :versions
    attr_reader :responses
    attr_accessor :params
    attr_accessor :name
    attr_accessor :description
    attr_accessor :priority
    attr_accessor :ssl
    attr_accessor :authentication

    # Resource constructor
    #
    # @param http_berb [Symbol] Resource http verb.
    # @param url [String] Resource's url. The url will automatically be prepended a slash if it doesn't already contain one.
    # @api public
    def initialize(http_verb, url)
      @url                 = url.start_with?('/') ? url : "/#{url}"
      @http_verb           = http_verb
      @formats             = Set.new
      @versions            = Set.new
      @priority            = 50
      @ssl                 = false
      @authentication      = false
      @params              = Class.new(Params)
      @responses           = Kanpachi::ResponseList.new
    end

    # Returns true if the resource has defined any params.
    #
    # @return [Boolean]
    def params?
      !(params.input_filters.required_inputs.empty? && params.input_filters.optional_inputs.empty?)
    end

    # Compare two resources using the priority
    def <=> (other)
      priority <=> other.priority
    end

    # Returns the http verb concatenated with the url
    def route
      "#{@http_verb.to_s.upcase} #{@url}"
    end
  end
end
