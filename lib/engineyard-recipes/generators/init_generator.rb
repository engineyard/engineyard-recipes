require 'thor/group'
require 'engineyard-recipes/generators/base_generator'

module Engineyard::Recipes
  module Generators
    class InitGenerator < BaseGenerator
      include Thor::Actions

      argument :on_deploy, :optional => true
      
      def self.source_root
        File.join(File.dirname(__FILE__), "init_generator", "templates")
      end
      
      def install_cookbooks
        if on_deploy
          directory "deploy"
        end
        unless File.exists?(File.join(destination_root, "#{cookbooks_destination}/main/recipes/default.rb"))
          directory "cookbooks", cookbooks_destination
        end
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
