require 'thor/group'

module Engineyard::Recipes
  module Generators
    class RecipeGenerator < Thor::Group
      include Thor::Actions
      
      argument :name

      def self.source_root
        File.join(File.dirname(__FILE__), "recipe_generator", "templates")
      end
      
      def install_cookbooks
        directory "cookbooks"
      end
      
      private
      def say(msg, color = nil)
        color ? shell.say(msg, color) : shell.say(msg)
      end
    end
  end
end
