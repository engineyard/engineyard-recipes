require 'thor/group'

module Engineyard::Recipes
  module Generators
    class GemGenerator < BaseGenerator
      include Thor::Actions

      argument :recipe_name
      argument :repo_name
      
      def self.source_root
        File.join(File.dirname(__FILE__), "gem_generator", "templates")
      end
      
      def install_gem
        directory "gem", repo_name
      end
      
      def install_recipe
        directory "recipe", repo_name
      end
      
      protected
      def cookbooks_destination
        if on_deploy
          "deploy/cookbooks"
        else
          "cookbooks"
        end
      end
    end
  end
end
