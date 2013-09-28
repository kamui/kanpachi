require 'thor/group'

module Kanpachi
  module Commands
    class New < Thor::Group
      include Thor::Actions

      desc 'Generate a new API'
      argument :name, type: :string, desc: "The name of the API to generate"
      class_option :test_framework, default: :minitest

      def self.source_root
        File.expand_path(File.join('..', 'templates'), File.dirname(__FILE__))
      end

      def create_app
        directory ".", "#{name}"
      end

      protected
      def name_const
        @name_const ||= Inflecto.camelize(name.gsub(/\W/, '_').squeeze('_'))
      end
    end
  end
end
