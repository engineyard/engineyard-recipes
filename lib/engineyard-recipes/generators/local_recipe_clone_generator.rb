require 'thor/group'

module Engineyard::Recipes
  module Generators
    class LocalRecipeCloneGenerator < BaseGenerator
      include Thor::Actions
      
      argument :recipe_name
      argument :flags, :type => :hash

      def self.source_root
        @tmpdir ||= Dir.mktmpdir
      end
      
      def install_cookbooks
        directory "cookbooks", cookbooks_destination
      end
      
      def auto_require_package
        unless local?
          file = cookbooks_dir "main/recipes/default.rb"
          require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
          append_to_file file, require_recipe
        end
      end
      
      private
      def local?
        flags[:local]
      end
    end
  end
end
