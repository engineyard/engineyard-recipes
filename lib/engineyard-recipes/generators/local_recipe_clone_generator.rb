require 'thor/group'

module Engineyard::Recipes
  module Generators
    class LocalRecipeCloneGenerator < Thor::Group
      include Thor::Actions
      
      argument :recipe_name
      argument :target_root

      def self.source_root
        @tmpdir ||= Dir.mktmpdir
      end
      
      def install_cookbooks
        directory "cookbooks", target_root # either "cookbooks" or "."
      end
      
      def auto_require_package
        if cookbooks?
          file = "cookbooks/main/recipes/default.rb"
          file_path = File.join(destination_root, "cookbooks/main/recipes/default.rb")
          if !File.exists?(file_path)
            puts "Skipping auto-require of package recipe: #{file} is missing"
          elsif File.directory?(File.join(self.class.source_root, "cookbooks", recipe_name, "recipes"))
            require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
            append_to_file file, require_recipe
          end
        end
      end
      
      private
      def say(msg, color = nil)
        color ? shell.say(msg, color) : shell.say(msg)
      end

      def cookbooks?
        target_root == "cookbooks"
      end
    end
  end
end
