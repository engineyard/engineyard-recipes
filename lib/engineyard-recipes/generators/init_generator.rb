require 'thor/group'

module Engineyard::Recipes
  module Generators
    class InitGenerator < Thor::Group
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
      
      private
      def cookbooks_destination
        if on_deploy
          "deploy/cookbooks"
        else
          "cookbooks"
        end
      end
      
      def say(msg, color = nil)
        color ? shell.say(msg, color) : shell.say(msg)
      end
    end
  end
end
