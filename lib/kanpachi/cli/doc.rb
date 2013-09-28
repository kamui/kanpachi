ENV['MM_ROOT'] = '/Users/jack/Development/kanpachi/lib/kanpachi/doc'

module Kanpachi
  module SubCommand
  # class CLI < Thor
    class Doc < Thor
      namespace :doc

      desc "doc:generate_doc API_NAME, SOURCE_PATH DESTINATION_PATH", "Generate HTML documentation for Kanpachi web services"
      def generate_doc(api_name, source_path, destination_path="doc")
        puts "Starting"
        api_files = Dir.glob(File.join(destination_root, source_path, "**", "*.rb"))
        if api_files.empty?
          puts "No ruby files in source_path: #{File.join(destination_root, source_path)}"
          return
        end
        api_files.each do |file|
          require file
        end

        api = APIList.find(api_name)

        require 'fileutils'
        destination = File.join(destination_root, destination_path)
        FileUtils.mkdir_p(destination) unless File.exist?(destination)
        File.open("#{destination}/index.html", "w"){|f| f << doc_template.result(binding)}
        puts "Documentation available there: #{destination}/index.html"
        `open #{destination}/index.html` if RUBY_PLATFORM =~ /darwin/ && !ENV['DONT_OPEN']
      end

      private

      def response_html(attrs)
        response_template.result(binding)
      end

      def input_params_html(required, optional)
        input_params_template.result(binding)
      end

      def input_params_template
        file = resources.join '_input_params.erb'
        ERB.new File.read(file)
      end

      def response_template
        file = resources.join '_response.erb'
        ERB.new File.read(file)
      end

      def doc_template
        file = resources.join 'template.erb'
        ERB.new File.read(file)
      end

      def resources
        require 'pathname'
        @resources ||= Pathname.new(File.join(File.dirname(__FILE__), 'doc_generator'))
      end
    end
  end
end
