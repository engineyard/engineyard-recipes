Feature: Setup your EY Cloud cookbook to use SM framework extensions
  I want to write my customizations in SM framework
  And have them work on EY Cloud
  
  Background:
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init"
  
  Scenario: Wrap a 
    When I run local executable "ey-recipes" with arguments "init-sm"
    Then file "cookbooks/sm/recipes/default.rb" contains "require_recipe 'sm::install'"
    Then file "cookbooks/sm/recipes/install.rb" contains "curl -L -s https://github.com/sm/sm/tarball/master -o sm-master.tar.gz"
    And I should see exactly
      """
             exist  cookbooks
            create  cookbooks/sm/attributes/recipe.rb
            create  cookbooks/sm/recipes/default.rb
            create  cookbooks/sm/recipes/install.rb
            append  cookbooks/main/recipes/default.rb
      """
