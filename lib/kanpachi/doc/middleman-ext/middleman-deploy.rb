require 'thor'
require 'middleman-core'
require 'middleman-core/cli'
require 'kanpachi'

begin
  require 'middleman-deploy'
rescue LoadError
end

if defined? Middleman::Cli::Deploy
  class Middleman::Cli::Deploy
    default_task :deploy
  end

  module Kanpachi
    class CLI < Thor
      task = ::Middleman::Cli::Deploy.tasks['deploy']
      register ::Middleman::Cli::Deploy, 'deploy', task.usage, task.description, task.options
    end
  end
end