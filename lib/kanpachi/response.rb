require 'roar/representer/json'
require 'roar/decorator'
require 'representable/json/collection'
require 'representable/json/hash'

module Kanpachi
  class Response
    attr_reader :name
    attr_reader :headers
    attr_accessor :status
    attr_accessor :representation

    def initialize(name)
      @name = name
      @status = 200
      @headers = {}
      @representation = Class.new(Roar::Decorator) { include Representation }
    end

    module Representation
      def self.included(base)
        base.class_eval do
          include Roar::Representer::JSON
          include Roar::Decorator::HypermediaConsumer

          def self.example
            example = Hash.new
            self.properties.each do |key, value|
              if value[:hash]
                example[key] = value[:extend] ? value[:extend].example : (value[:example] || Hash.new)
              elsif value[:collection]
                example[key] = value[:extend] ? [value[:extend].example] : (value[:example] || Array.new)
              elsif value[:type] == Integer
                example[key] = value[:example] || 1
              elsif value[:type] == String
                example[key] = value[:example] || 'String'
              elsif !!value[:type] == value[:type]
                example[key] = value[:example] || true
              elsif value[:type] == DateTime
                example[key] = value[:example] || "2013-01-01T19:06:43Z"
              else
                example[key] = value[:example] || 'String'
              end
            end
            if self.included_modules.include?(::Representable::JSON::Collection)
              example = [example]
            elsif self.included_modules.include?(::Representable::JSON::Hash)
              example = example['_self'] || Hash.new
            end
            example
          end

          def self.properties
            hash = Hash.new
            representable_attrs.each do |definition|
              if definition.options[:extend]
                hash[definition.name] = definition.options.merge(definition.options[:extend].properties)
              else
                hash[definition.name] = definition.options
              end
            end
            hash
          end
        end
      end
    end
  end
end
