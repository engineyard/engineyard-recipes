require 'thor/group'

module Engineyard::Recipes
  module Generators
    class LocalRecipeCloneGenerator < BaseGenerator
      include Thor::Actions
      
      argument :recipe_name

      def self.source_root
        @tmpdir ||= Dir.mktmpdir
      end
      
      def install_cookbooks
        directory "cookbooks", cookbooks_destination
      rescue CookbooksNotFound
        directory "cookbooks/#{recipe_name}", "."
      end
      
      def auto_require_package
        file = cookbooks_dir "main/recipes/default.rb"
        require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
        append_to_file file, require_recipe
      rescue CookbooksNotFound
        # step not required if no cookbooks/ found
      end
      
      private
      def local?
        flags[:local]
      end
    end
  end
end
