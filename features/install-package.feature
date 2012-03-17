Feature: Install a gentoo package
  I want to generate a new chef recipe that will install a package
  And it is automatically included in the main recipe/run
  
  Background:
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init"
  
  Scenario: Generate a new recipe
    When I run local executable "ey-recipes" with arguments "package new-component"
    And file "cookbooks/new-component/recipes/default.rb" is created
    And file "cookbooks/new-component/recipes/default.rb" contains "require_recipe 'new-component::install'"
    And file "cookbooks/new-component/recipes/install.rb" is created
    And file "cookbooks/new-component/attributes/recipe.rb" is created
    And file "cookbooks/new-component/attributes/recipe.rb" contains "# new-component_version('1.0.0')"
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
    When I run local executable "ey-recipes" with arguments "package new-component"
    When I run local executable "ey-recipes" with arguments "package new-component"
    And I should see exactly
      """
             exist  cookbooks
         identical  cookbooks/new-component/attributes/recipe.rb
         identical  cookbooks/new-component/recipes/default.rb
         identical  cookbooks/new-component/recipes/install.rb
            append  cookbooks/main/recipes/default.rb
      """

  Scenario: Generate a new recipe for a specific package/version that is stable
    When I run local executable "ey-recipes" with arguments "package gitosis -p dev-util/gitosis-gentoo -v 0.2_p20081028"
    And file "cookbooks/gitosis/recipes/default.rb" is created
    And file "cookbooks/gitosis/recipes/default.rb" contains "require_recipe 'gitosis::install'"
    And file "cookbooks/gitosis/recipes/install.rb" is created
    And file "cookbooks/gitosis/attributes/recipe.rb" is created
    And file "cookbooks/gitosis/attributes/recipe.rb" contains "gitosis_version('0.2_p20081028')"
    And file "cookbooks/gitosis/recipes/install.rb" contains
    """
    #
    # Cookbook Name:: gitosis
    # Recipe:: install
    #

    package 'dev-util/gitosis-gentoo' do
      version node[:gitosis_version]
      action :install
    end

    """    

  Scenario: Generate a new recipe for a specific package/version that is masked
    When I run local executable "ey-recipes" with arguments "package gitosis -p dev-util/gitosis-gentoo -v 0.2_p20081028 -u"
    And file "cookbooks/gitosis/recipes/default.rb" is created
    And file "cookbooks/gitosis/recipes/default.rb" contains "require_recipe 'gitosis::install'"
    And file "cookbooks/gitosis/recipes/install.rb" is created
    And file "cookbooks/gitosis/attributes/recipe.rb" is created
    And file "cookbooks/gitosis/attributes/recipe.rb" contains "gitosis_version('0.2_p20081028')"
    And file "cookbooks/gitosis/attributes/recipe.rb" does not contain "# gitosis_version('0.2_p20081028')"
    And file "cookbooks/gitosis/recipes/install.rb" contains
    """
    #
    # Cookbook Name:: gitosis
    # Recipe:: install
    #

    enable_package 'dev-util/gitosis-gentoo' do
      version node[:gitosis_version]
    end

    package 'dev-util/gitosis-gentoo' do
      version node[:gitosis_version]
      action :install
    end
    
    """    

  Scenario: Generate a new recipe into local folder instead of in cookbooks/
    When I run local executable "ey-recipes" with arguments "package component --local"
    And file "component/recipes/default.rb" is created
    And file "component/recipes/default.rb" contains "require_recipe 'component::install'"
    And file "component/recipes/install.rb" is created
    And file "component/attributes/recipe.rb" is created
    And file "component/attributes/recipe.rb" contains "# component_version('1.0.0')"
    And I should see exactly
      """
             exist  
            create  component/attributes/recipe.rb
            create  component/recipes/default.rb
            create  component/recipes/install.rb
      """

