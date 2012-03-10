require 'thor/group'

module Engineyard::Recipes
  module Generators
    class InitSmGenerator < BaseGenerator
      include Thor::Actions
      
      def self.source_root
        File.join(File.dirname(__FILE__), "init_sm_generator", "templates")
      end
      
      def install_cookbooks
        directory "cookbooks", cookbooks_destination
      end
      
      def auto_require_package
        file           = cookbooks_dir("main/recipes/default.rb")
        require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
        append_to_file file, require_recipe
      end
      
      private      
      def recipe_name
        'sm'
      end
    end
  end
end
