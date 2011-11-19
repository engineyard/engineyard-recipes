require 'thor/group'

module Engineyard::Recipes
  module Generators
    class SmGenerator < Thor::Group
      include Thor::Actions
      attr_accessor :command
      
      argument :recipe_name
      argument :sm_ext_uri
      argument :sm_ext_commands, :type => :array
      argument :sm_local_path, :required => false

      def self.source_root
        File.join(File.dirname(__FILE__), "sm_generator", "templates")
      end
      
      def install_cookbooks
        directory "cookbooks"
      end
      
      def wrap_commands
        template_file = 'command_recipe.rb.tt'
        sm_ext_commands.each do |command|
          self.command = command # for the template
          recipe = "cookbooks/#{recipe_name}/recipes/#{command}.rb"
          template(template_file, recipe)
        end
      end
      
      def auto_require_package
        file = "cookbooks/main/recipes/default.rb"
        file_path = File.join(destination_root, "cookbooks/main/recipes/default.rb")
        unless File.exists?(file_path)
          puts "Skipping auto-require of package recipe: #{file} is missing"
        else
          require_recipe = "\nrequire_recipe '#{recipe_name}'\n"
          append_to_file file, require_recipe
        end
      end
      
      private
      def say(msg, color = nil)
        color ? shell.say(msg, color) : shell.say(msg)
      end
      
    end
  end
end
