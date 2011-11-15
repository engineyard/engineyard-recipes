Feature: Clone recipe from git repositories
  I want to quickly generate recipes from existing git repositories
  From either the whole repository or a specific folder
  
  Background:
    Given I am in the "rails" project folder
    Given I am have a local recipe "blank" at "/tmp/ey-recipes/blank"
    When I run local executable "ey-recipes" with arguments "init"
  
  @wip
  Scenario: Clone a recipe from local folder
    When I run local executable "ey-recipes" with arguments "clone /tmp/ey-recipes/blank --name myrecipe"
    Then file "cookbooks/emerge/recipes/default.rb" is created
    And I should see exactly
      """
            create  cookbooks/myrecipe/README.rdoc
      """

  @wip
  Scenario: Clone a recipe from engineyard/ey-cloud-recipes repository
    When I run local executable "ey-recipes" with arguments "clone git://github.com/engineyard/ey-cloud-recipes.git --recipe emerge"
    Then file "cookbooks/emerge/recipes/default.rb" is created
    And I should see exactly
      """
            create  cookbooks/emerge/definitions/enable_package.rb
            create  cookbooks/emerge/definitions/package_use.rb
            create  cookbooks/emerge/definitions/update_file.rb
            create  cookbooks/emerge/README.rdoc
      """
    
  @wip
  Scenario: Clone repository as an entire recipe
    When I run local executable "ey-recipes" with arguments "clone git://github.com/damm/ey-dnapi.git --name dnapi"
    Then file "cookbooks/dnapi/libraries/engineyard.rb" is created
    And I should see exactly
      """
            create  cookbooks/dnapi/libraries/engineyard.rb
            create  cookbooks/dnapi/README.rdoc
      """
    
  
  
  
