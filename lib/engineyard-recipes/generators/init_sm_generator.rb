require 'thor/group'

module Engineyard::Recipes
  module Generators
    class InitSmGenerator < Thor::Group
      include Thor::Actions
      
      def self.source_root
        File.join(File.dirname(__FILE__), "init_sm_generator", "templates")
      end
      
      def install_cookbooks
        directory "cookbooks"
      end
      
      def auto_require_package
        file = "cookbooks/main/recipes/default.rb"
        file_path = File.join(destination_root, "cookbooks/main/recipes/default.rb")
        unless File.exists?(file_path)
          puts "Skipping auto-require of package recipe: #{file} is missing"
        else
          require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
          append_to_file file, require_recipe
        end
      end
      
      private
      def say(msg, color = nil)
        color ? shell.say(msg, color) : shell.say(msg)
      end
      
      def recipe_name
        'sm'
      end
    end
  end
end
