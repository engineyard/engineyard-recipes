module Engineyard::Recipes
  module FetchUri
    extend self
    
    # Fetch the target at URI (git url or local folder path)
    # Return path to a local folder structure that contains "cookbooks/<recipe name>"
    def fetch_recipe(uri, source_root, recipe_name = nil)
      if File.exists?(uri)
        normalize_fetched_project(uri, source_root, recipe_name)
      end
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
    def normalize_fetched_project(path, store_path, recipe_name = nil)
      recipe_name ||= File.basename(path)
      FileUtils.rm_rf(store_path)
      FileUtils.mkdir_p(store_path)
      initial_storage = Dir.mktmpdir
      initial_storage_cookbooks = File.join(initial_storage, "cookbooks")
      if Dir.exists?(File.join(path, "cookbooks"))
        # FIXME untested
        FileUtils.cp_r("#{path}/", initial_storage)
      else
        FileUtils.mkdir_p(initial_storage_cookbooks)
        FileUtils.cp_r(path, File.join(initial_storage, "cookbooks", recipe_name))
      end
      FileUtils.cp_r(initial_storage_cookbooks, store_path)
    end
  end
end
