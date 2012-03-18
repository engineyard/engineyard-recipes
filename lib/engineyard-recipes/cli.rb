require 'thor'
require 'engineyard-recipes/thor-ext/actions/directory'
require 'engineyard-recipes/fetch_uri'
require 'engineyard-recipes/generators/base_generator'

module Engineyard
  module Recipes
    class CLI < Thor

      desc "init", "Creates cookbooks scaffolding for your recipes"
      method_option :"on-deploy", :aliases => ['-d'], :type => :boolean, :desc => "Run recipes during deployment"
      method_option :sm, :type => :boolean, :desc => "Also install SM framework support"
      def init
        on_deploy = options["on-deploy"] || false
        
        require 'engineyard-recipes/generators/init_generator'
        Engineyard::Recipes::Generators::InitGenerator.start([on_deploy])
        init_sm if options[:sm]
      end
      
      desc "init-sm", "Setup your EY Cloud cookbook to use SM framework extensions"
      def init_sm
        require 'engineyard-recipes/generators/init_sm_generator'
        Engineyard::Recipes::Generators::InitSmGenerator.start
      end
      
      desc "package PACKAGE", "Install a gentoo ebuild package"
      method_option :package, :aliases => ['-p'], :desc => "Gentoo package name, e.g. dev-util/gitosis-gentoo"
      method_option :version, :aliases => ['-v'], :desc => "Gentoo package version, e.g. 0.2_p20081028"
      method_options %w( unmasked -u ) => :boolean, :desc => "Unmask the required gentoo package"
      def package(recipe_name)
        package  = options["package"] || "UNKNOWN/#{recipe_name}"
        version  = options["version"] || '1.0.0'
        unmasked = options["unmasked"] || false
        
        require 'engineyard-recipes/generators/package_generator'
        Engineyard::Recipes::Generators::PackageGenerator.start([
          recipe_name, package, version, {:unmasked => unmasked}
        ])
      end
      
      desc "gem NAME", "Name of the recipe"
      method_option :repo, :aliases => ['-r'], :desc => "Name of the repository. Default: eycloud-recipes-NAME"
      def gem(recipe_name)
        repo_name ||= options["repo"] || "eycloud-recipe-#{recipe_name}"

        require 'engineyard-recipes/generators/gem_generator'
        Engineyard::Recipes::Generators::GemGenerator.start([recipe_name, repo_name])
      end
      
      desc "definition RECIPE DEFINITION", "Generate recipe for a package"
      def definition(recipe_name, definition_name)
        require 'engineyard-recipes/generators/definition_generator'
        Engineyard::Recipes::Generators::DefinitionGenerator.start([recipe_name, definition_name])
      end
      
      desc "timezone TIMEZONE", "Generate recipe to set the timezone"
      def timezone(timezone)
        require 'engineyard-recipes/generators/timezone_generator'
        Engineyard::Recipes::Generators::TimezoneGenerator.start([timezone])
      rescue Engineyard::Recipes::Generators::TimezoneGenerator::InvalidTimezone => e
        error "#{e.message} is not a known timezone."
      end
      
      desc "clone URI", "Clone a recipe into cookbook. URI can be git or local path."
      method_option :name, :aliases => ['-n'], :desc => "Specify name of recipe. Defaults to base name."
      def clone(folder_path) # TODO support git URIs
        require 'engineyard-recipes/generators/local_recipe_clone_generator'
        generator = Engineyard::Recipes::Generators::LocalRecipeCloneGenerator
        _, recipe_name = FetchUri.fetch_recipe(folder_path, generator.source_root, options["name"])
        generator.start([recipe_name])
        
      rescue Engineyard::Recipes::FetchUri::UnknownPath => e
        error "No recipe found at #{e.message}"
      end
      
      desc "sm URI [COMMANDS]", "Wrap an SM extension as an eychef recipe"
      method_option :name, :aliases => ['-n'], :desc => "Specify name of recipe. Defaults to base name.", :required => true
      def sm(uri, *commands)
        require 'engineyard-recipes/generators/sm_generator'
        recipe_name = options["name"]
        
        Engineyard::Recipes::Generators::SmGenerator.start([recipe_name, uri, commands])
      end
      
      desc "version", "show version information"
      def version
        require 'engineyard-recipes/version'
        shell.say Engineyard::Recipes::VERSION
      end

      map "-v" => :version, "--version" => :version, "-h" => :help, "--help" => :help

      private
      def say(msg, color = nil)
        color ? shell.say(msg, color) : shell.say(msg)
      end

      def display(text)
        shell.say text
        exit
      end

      def error(text)
        shell.say "ERROR: #{text}", :red
        exit
      end
      
      def no_environments_discovered
        say "No environments with name recipes, recipes_server, recipes_production, recipes_server_production.", :red
        say "Either:"
        say "  * Create an Engine Yard Cloud environment called recipes, recipes_server, recipes_production, recipes_server_production"
        say "  * Use --environment/--account flags to select Engine Yard Cloud environment"
      end
      
      def too_many_environments_discovered(environments)
        say "Multiple environments possible, please be more specific:", :red
        say ""
        environments.each do |env_name, account_name, environment|
          say "  ey-recipes install_server --environment "; say "'#{env_name}' ", :yellow; 
            say "--account "; say "'#{account_name}'", :yellow
        end
      end
      
      def watch_page_while(host, port, path)
        waiting = true
        while waiting
          begin
            Net::HTTP.start(host, port) do |http|
              req = http.get(path)
              waiting = yield req
            end
            sleep 1; print '.'; $stdout.flush
          rescue SocketError => e
            sleep 1; print 'x'; $stdout.flush
          rescue Exception => e
            puts e.message
            sleep 1; print '.'; $stdout.flush
          end
        end
      end
    end
  end
end
