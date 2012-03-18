require 'thor/group'

module Engineyard::Recipes
  module Generators
    class UseGenerator < BaseGenerator
      include Thor::Actions
      
      argument :recipe_name

      def self.source_root
        File.join(File.dirname(__FILE__), "use_generator", "templates")
      end
      
      def auto_require_package
        file           = cookbooks_dir "main/recipes/default.rb"
        require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
        append_to_file file, require_recipe
      rescue CookbooksNotFound
        error "Please run 'ey-recipes init' or 'ey-recipes init --on-deploy' first."
      end
      
      def gemfile
        gem_cmd = %Q{\ngem '#{recipe_name}', :group => :eycloud\n}
        append_to_file "Gemfile", gem_cmd
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
