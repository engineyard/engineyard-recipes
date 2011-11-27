Feature: Setup your EY Cloud cookbook to use SM framework extensions
  I want to write my customizations in SM framework
  And have them work on EY Cloud
  
  Scenario: Setup existing EY Cloud custom cookbooks for SM extensions
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init"
    When I run local executable "ey-recipes" with arguments "init-sm"
    Then file "cookbooks/sm/recipes/default.rb" contains "require_recipe 'sm::install'"
    Then file "cookbooks/sm/recipes/install.rb" contains "curl -L -s https://github.com/sm/sm/tarball/master -o sm-master.tar.gz"
    # Then file "cookbooks/main/recipes/default.rb" contains "require_recipe 'eyapi'"
    Then file "cookbooks/main/recipes/default.rb" contains "require_recipe 'sm'"
    And I should see exactly
      """
             exist  cookbooks
            create  cookbooks/sm/attributes/recipe.rb
            create  cookbooks/sm/recipes/default.rb
            create  cookbooks/sm/recipes/install.rb
            append  cookbooks/main/recipes/default.rb
      """
      # create  cookbooks/eyapi/attributes/recipe.rb
      # create  cookbooks/eyapi/recipes/default.rb
      # create  cookbooks/eyapi/recipes/install.rb

  Scenario: Create new EY CLoud custom cookbooks with SM extensions
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init --sm"
    And I should see exactly
      """
            create  cookbooks
            create  cookbooks/main/attributes/recipe.rb
            create  cookbooks/main/definitions/ey_cloud_report.rb
            create  cookbooks/main/libraries/ruby_block.rb
            create  cookbooks/main/libraries/run_for_app.rb
            create  cookbooks/main/recipes/default.rb
             exist  cookbooks
            create  cookbooks/sm/attributes/recipe.rb
            create  cookbooks/sm/recipes/default.rb
            create  cookbooks/sm/recipes/install.rb
            append  cookbooks/main/recipes/default.rb
      """
      # create  cookbooks/eyapi/attributes/recipe.rb
      # create  cookbooks/eyapi/recipes/default.rb
      # create  cookbooks/eyapi/recipes/install.rb
