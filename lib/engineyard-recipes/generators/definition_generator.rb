require 'thor/group'

module Engineyard::Recipes
  module Generators
    class DefinitionGenerator < BaseGenerator
      include Thor::Actions
      
      argument :recipe_name
      argument :definition_name

      def self.source_root
        File.join(File.dirname(__FILE__), "definition_generator", "templates")
      end
      
      def install_cookbooks
        directory "cookbooks", cookbooks_destination
      rescue CookbooksNotFound
        directory "cookbooks/%recipe_name%", "."
      end
    end
  end
end
