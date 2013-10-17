require 'thor'
require 'middleman-core'
require 'middleman-core/cli'
require 'middleman-core/profiling'
require 'kanpachi'
require 'kanpachi/commands/new'

# doc template requires these gems
require 'inflecto'
require 'json'

ENV['MM_ROOT'] = File.join(File.expand_path(File.dirname(__FILE__)), 'doc', 'template')

class Middleman::Cli::Server
  default_task :server
end

class Middleman::Cli::Build
  default_task :build
end

module Kanpachi
  class CLI < Thor
    namespace :kanpachi

    register Commands::New, 'new', 'new [NAME]', 'Generate a new API'

    task = ::Middleman::Cli::Server.tasks['server']
    register ::Middleman::Cli::Server, 'server', task.usage, task.description, task.options

    task = ::Middleman::Cli::Build.tasks['build']
    register ::Middleman::Cli::Build, 'build', task.usage, task.description, task.options
  end
end

require 'kanpachi/doc/middleman-ext/middleman-deploy'