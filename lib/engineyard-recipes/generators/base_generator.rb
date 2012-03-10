require 'thor/group'

module Engineyard::Recipes
  module Generators
    class BaseGenerator < Thor::Group
      include Thor::Actions

      protected
      def cookbooks_destination
        @cookbooks_destination ||= begin
          return "." if self.respond_to?(:flags) && flags[:local] # check for bonus --local flag in CLI
          possible_paths = ['deploy/cookbooks', 'cookbooks']
          destination = possible_paths.find do |cookbooks|
            Dir.exist?(File.join(destination_root, cookbooks))
          end
          unless destination
            error "Cannot discover cookbooks folder"
          end
          destination
        end
      end
      
      def cookbooks_dir(child_path)
        File.join(cookbooks_destination, child_path)
      end
      
      def say(msg, color = nil)
        color ? shell.say(msg, color) : shell.say(msg)
      end
    end
  end
end