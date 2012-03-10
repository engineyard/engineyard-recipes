require 'thor/group'

module Engineyard::Recipes
  module Generators
    class RecipeGenerator < BaseGenerator
      include Thor::Actions
      
      argument :recipe_name
      argument :package
      argument :version
      argument :unmasked, :optional => true
      argument :local, :optional => true

      def self.source_root
        File.join(File.dirname(__FILE__), "recipe_generator", "templates")
      end
      
      def install_cookbooks
        directory "cookbooks", cookbooks_destination
      end
      
      def auto_require_package
        file = cookbooks_dir "main/recipes/default.rb"
        require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
        append_to_file file, require_recipe
      end
      
      private
      def say(msg, color = nil)
        color ? shell.say(msg, color) : shell.say(msg)
      end
      
      def known_package?
        package =~ /UNKNOWN/
      end
    end
  end
end
