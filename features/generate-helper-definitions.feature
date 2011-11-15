Feature: Generate helper definitions recipe
  I want to generate a new chef recipe for definition helpers
  
  Background:
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init"
  
  Scenario: Generate a new recipe
    When I run local executable "ey-recipes" with arguments "definition mylibrary helper1"
    And file "cookbooks/new-component/definitions/helper1.rb" is created
    And file "cookbooks/new-component/definitions/helper1.rb" contains "define :helper1 do"
    And I should see exactly
      """
            create  cookbooks/new-component/definitions
            create  cookbooks/new-component/definitions/helper1.rb
      
      Lovely.
      """
  
  Scenario: Generate a recipe that already exists
    When I run local executable "ey-recipes" with arguments "definition mylibrary helper1"
    When I run local executable "ey-recipes" with arguments "definition mylibrary helper2"
    And I should see exactly
      """
            exists  cookbooks/new-component/definitions
            create  cookbooks/new-component/definitions/helper2.rb
      
      Lovely.
      """
  
  
  
