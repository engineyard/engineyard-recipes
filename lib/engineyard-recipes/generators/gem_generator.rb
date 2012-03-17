require 'thor/group'
require 'active_support/core_ext/string'

module Engineyard::Recipes
  module Generators
    class GemGenerator < BaseGenerator
      include Thor::Actions

      argument :recipe_name
      argument :repo_name
      
      def self.source_root
        File.join(File.dirname(__FILE__), "gem_generator", "templates")
      end
      
      def install_gem
        directory "gem", repo_name
      end
      
      def install_recipe
        directory "recipe", repo_name
      end
      
      protected
      def git_user_name
        `git config user.name`.strip
      end

      def git_user_email
        `git config user.email`.strip
      end
    end
  end
end
