require 'thor/group'

module Engineyard::Recipes
  module Generators
    class InitGenerator < Thor::Group
      include Thor::Actions
      
      def self.source_root
        File.join(File.dirname(__FILE__), "init_generator", "templates")
      end
      
      def install_cookbooks
        file       = "cookbooks/main/recipes/default.rb"
        unless File.exists?(File.join(destination_root, "cookbooks/main/recipes/default.rb"))
          directory "cookbooks"
        end
      end
      
      private
      def say(msg, color = nil)
        color ? shell.say(msg, color) : shell.say(msg)
      end
    end
  end
end
