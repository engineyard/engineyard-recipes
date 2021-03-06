require 'thor/group'

module Engineyard::Recipes
  module Generators
    class PackageGenerator < BaseGenerator
      include Thor::Actions
      
      argument :recipe_name
      argument :package
      argument :version
      argument :flags, :type => :hash # :unmasked

      def self.source_root
        File.join(File.dirname(__FILE__), "package_generator", "templates")
      end
      
      def install_cookbooks
        begin
          directory "cookbooks", cookbooks_destination
        rescue CookbooksNotFound
          directory "cookbooks/%recipe_name%", "."
        end
      end
      
      def auto_require_package
        file           = cookbooks_dir "main/recipes/default.rb"
        require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
        append_to_file file, require_recipe
      rescue CookbooksNotFound
        # step not required if no cookbooks/ found
      end
      
      protected
      def recipe_name_variable_name
        @recipe_name_variable_name ||= recipe_name.gsub(/\W+/, '_')
      end
      
      def known_package?
        package =~ /UNKNOWN/
      end
      
      def local?
        flags[:local]
      end
      
      def unmasked
        flags[:unmasked]
      end
    end
  end
end
