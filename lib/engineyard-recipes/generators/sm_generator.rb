require 'thor/group'

module Engineyard::Recipes
  module Generators
    class SmGenerator < BaseGenerator
      include Thor::Actions
      attr_accessor :command
      
      argument :recipe_name
      argument :sm_ext_uri
      argument :sm_ext_commands, :type => :array
      argument :flags, :required => false

      def self.source_root
        File.join(File.dirname(__FILE__), "sm_generator", "templates")
      end
      
      def install_cookbooks
        directory "cookbooks", cookbooks_destination
      end
      
      def wrap_commands
        template_file = 'command_recipe.rb.tt'
        sm_ext_commands.each do |command|
          self.command = command # for the template
          recipe = cookbooks_dir "#{recipe_name}/recipes/#{command}.rb"
          template(template_file, recipe)
        end
      end
      
      def auto_require_package
        file = cookbooks_dir "main/recipes/default.rb"
        require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
        append_to_file file, require_recipe
      end
      
      def vendor
        if submodule?
          FetchUri.vendor_recipe_into_recipe(sm_ext_uri, sm_vendor_path)
        end
      end
      
      protected
      def submodule?
        flags[:submodule]
      end
      
      def sm_vendor_path_name
        "repo"
      end
      
      def sm_vendor_path
        cookbooks_dir File.join(recipe_name, "repo")
      end
    end
  end
end
