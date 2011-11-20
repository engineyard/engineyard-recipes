$:.unshift(File.expand_path("..", __FILE__))
require "spec_helper"
require "engineyard-recipes/fetch_uri"

describe Engineyard::Recipes::FetchUri do
  # Fetch the target at URI (git url or local folder path)
  #
  # Returns a tuple:
  # * path to a local folder structure that contains "cookbooks/<recipe name>"
  # * recipe_name
  describe "#fetch_recipe" do
  end


  # Vendor/submodule the +uri+ into current git repo at +sm_vendor_path+
  # If +uri+ is a local folder, then copy folder to +sm_vendor_path+
  # If +uri+ is a remote git repo, then submodule to +sm_vendor_path+
  describe "#vendor_recipe_into_recipe" do
  end
  
  
  # Takes a folder that is either a cookbooks/<recipes> structure, or
  # assumed to be a singular <recipe>/
  # Copies it into +store_path+ and resulting folder
  # guaranteed to be in cookbooks/<recipes> structure
  #
  # For example, if the +path+ is:
  #  path/
  #    ey-dnapi/
  #      libraries/
  #        engineyard.rb
  # 
  # Then the resulting +store_path+ will be:
  #   tmpdir/
  #     cookbooks/
  #       ey-dnapi/
  #         libraries/
  #           engineyard.rb
  #
  # If +path+/cookbooks exists, then +store_path+
  # will be a duplicate of +path+
  #
  # Can override the +<recipe>+ name with +recipe_name+
  #
  # Returns a tuple:
  # * path to a local folder structure that contains "cookbooks/<recipe name>"
  # * recipe_name
  describe "#normalize_fetched_project" do
  end
end