Feature: Generate package recipe
  I want to generate a new chef recipe for a package
  And it is automatically included in the main recipe/run
  
  Background:
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init"
  
  Scenario: Generate a new recipe
    When I run local executable "ey-recipes" with arguments "recipe new-component"
    And file "cookbooks/new-component/recipes/default.rb" is created
    And file "cookbooks/new-component/recipes/default.rb" contains "require_recipe 'new-component::install'"
    And file "cookbooks/new-component/recipes/install.rb" is created
    And file "cookbooks/new-component/attributes/recipe.rb" is created
    And file "cookbooks/main/recipes/default.rb" contains "require_recipe 'new-component'"
    And I should see exactly
      """
             exist  cookbooks
            create  cookbooks/new-component/attributes/recipe.rb
            create  cookbooks/new-component/recipes/default.rb
            create  cookbooks/new-component/recipes/install.rb
            append  cookbooks/main/recipes/default.rb
      """
  
  Scenario: Generate a recipe that already exists
    When I run local executable "ey-recipes" with arguments "recipe new-component"
    When I run local executable "ey-recipes" with arguments "recipe new-component"
    And I should see exactly
      """
             exist  cookbooks
         identical  cookbooks/new-component/attributes/recipe.rb
         identical  cookbooks/new-component/recipes/default.rb
         identical  cookbooks/new-component/recipes/install.rb
            append  cookbooks/main/recipes/default.rb
      """

  @wip
  Scenario: Generate a new recipe for a specific package/version
    When I run local executable "ey-recipes" with arguments "recipe gitosis -p dev-util/gitosis-gentoo -v 0.2_p20081028 --unmask"
    And file "cookbooks/gitosis/recipes/default.rb" is created
    And file "cookbooks/gitosis/recipes/default.rb" contains "require_recipe 'gitosis::install'"
    And file "cookbooks/gitosis/recipes/install.rb" is created
    And file "cookbooks/gitosis/attributes/recipe.rb" is created
    And file "cookbooks/gitosis/attributes/recipe.rb" contains "gitosis_version('0.2_p20081028')"
    And file "cookbooks/gitosis/recipes/default.rb" contains
    """
    #
    # Cookbook Name:: gitosis
    # Recipe:: install
    #

    enable_package "dev-util/gitosis-gentoo" do
      version node[:gitosis_version]
    end

    package "dev-util/gitosis-gentoo" do
      version node[:gitosis_version]
      action :install
    end
    """    

  
  
  