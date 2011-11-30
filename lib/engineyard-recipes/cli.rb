require 'thor'
require 'engineyard-recipes/thor-ext/actions/directory'
require 'engineyard-recipes/fetch_uri'

module Engineyard
  module Recipes
    class CLI < Thor

      desc "init", "Creates cookbooks scaffolding for your recipes"
      method_option :sm, :type => :boolean, :desc => "Also install SM framework support"
      def init
        require 'engineyard-recipes/generators/init_generator'
        Engineyard::Recipes::Generators::InitGenerator.start
        init_sm if options[:sm]
      end
      
      desc "init-sm", "Setup your EY Cloud cookbook to use SM framework extensions"
      def init_sm
        require 'engineyard-recipes/generators/init_sm_generator'
        Engineyard::Recipes::Generators::InitSmGenerator.start
      end
      
      desc "recipe RECIPE", "Generate recipe for a package"
      method_option :package, :aliases => ['-p'], :desc => "Gentoo package name, e.g. dev-util/gitosis-gentoo"
      method_option :version, :aliases => ['-v'], :desc => "Gentoo package version, e.g. 0.2_p20081028"
      method_options %w( unmasked -u ) => :boolean, :desc => "Unmask the required gentoo package"
      def recipe(recipe_name)
        package       = options["package"] || "UNKNOWN/#{recipe_name}"
        version       = options["version"] || '1.0.0'
        unmasked      = options["unmasked"] || false

        require 'engineyard-recipes/generators/recipe_generator'
        Engineyard::Recipes::Generators::RecipeGenerator.start([recipe_name, package, version, unmasked])
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
      end
      
      desc "clone URI", "Clone a recipe into cookbook. URI can be git or local path."
      method_option :name, :aliases => ['-n'], :desc => "Specify name of recipe. Defaults to base name."
      def clone(folder_path) # TODO support git URIs
        require 'engineyard-recipes/generators/local_recipe_clone_generator'
        generator = Engineyard::Recipes::Generators::LocalRecipeCloneGenerator
        local_cookbook_path, recipe_name = FetchUri.fetch_recipe(folder_path, generator.source_root, options["name"])
        generator.start([recipe_name])
      rescue Engineyard::Recipes::FetchUri::UnknownPath => e
        error "No recipe found at #{e.message}"
      end
      
      desc "sm URI [COMMANDS]", "Wrap an SM extension as an eychef recipe"
      method_option :name, :aliases => ['-n'], :desc => "Specify name of recipe. Defaults to base name.", :required => true
      method_option :submodule, :aliases => ['--vendor', '-s'], :desc => "Submodule the URI into recipe folder name"
      def sm(uri, *commands)
        require 'engineyard-recipes/generators/sm_generator'
        recipe_name      = options["name"]
        if options["submodule"]
          error "This project is not a git repository yet." unless File.directory?(".git")
          sm_vendor_path = File.join("cookbooks", recipe_name, options["submodule"])
        end
        Engineyard::Recipes::Generators::SmGenerator.start([recipe_name, uri, commands, sm_vendor_path])
        if sm_vendor_path
          FetchUri.vendor_recipe_into_recipe(uri, sm_vendor_path)
        end
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
