require 'thor/group'

module Engineyard::Recipes
  module Generators
    class LocalRecipeCloneGenerator < BaseGenerator
      include Thor::Actions
      
      argument :recipe_name
      argument :local, :optional => true

      def self.source_root
        @tmpdir ||= Dir.mktmpdir
      end
      
      def install_cookbooks
        directory "cookbooks", cookbooks_destination
      end
      
      def auto_require_package
        file = cookbooks_dir "main/recipes/default.rb"
        if File.directory?(File.join(self.class.source_root, "cookbooks", recipe_name, "recipes"))
          require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
          append_to_file file, require_recipe
        end
      end
    end
  end
end
