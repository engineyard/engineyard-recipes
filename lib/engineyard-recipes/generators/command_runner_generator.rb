require 'thor/group'

module Engineyard::Recipes
  module Generators
    class CommandRunnerGenerator < Thor::Group
      include Thor::Actions
      
      argument :command_name
      argument :command_to_run

      def self.source_root
        File.join(File.dirname(__FILE__), "command_runner_generator", "templates")
      end
      
      def install_cookbooks
        directory "cookbooks"
      end

      def auto_require_package
        file = "cookbooks/main/recipes/default.rb"
        file_path = File.join(destination_root, "cookbooks/main/recipes/default.rb")
        unless File.exists?(file_path)
          puts "Skipping auto-require of recipe: #{file} is missing"
        else
          require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
          append_to_file file, require_recipe
        end
      end
      
      protected
      def recipe_name
        command_name
      end

      def app_name
        command_name
      end
    end
  end
end
