require 'thor/group'

module Engineyard::Recipes
  module Generators
    class PackageGenerator < BaseGenerator
      include Thor::Actions
      
      argument :recipe_name
      argument :package
      argument :version
      argument :flags, :type => :hash # :unmasked & :local

      def self.source_root
        File.join(File.dirname(__FILE__), "package_generator", "templates")
      end
      
      def install_cookbooks
        directory "cookbooks", cookbooks_destination
      end
      
      def auto_require_package
        unless local?
          file           = cookbooks_dir "main/recipes/default.rb"
          require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
          append_to_file file, require_recipe
        end
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