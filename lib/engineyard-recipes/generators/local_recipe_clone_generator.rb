require 'thor/group'

module Engineyard::Recipes
  module Generators
    class LocalRecipeCloneGenerator < Thor::Group
      include Thor::Actions
      
      def self.source_root
        @tmpdir ||= Dir.mktmpdir
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
