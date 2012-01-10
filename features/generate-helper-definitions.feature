Feature: Generate helper definitions recipe
  I want to generate a new chef recipe for definition helpers
  
  Background:
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init"
  
  Scenario: Generate a new recipe
    When I run local executable "ey-recipes" with arguments "definition mylibrary helper1"
    And file "cookbooks/mylibrary/definitions/helper1.rb" is created
    And file "cookbooks/mylibrary/definitions/helper1.rb" contains "define :helper1 do"
    And I should see exactly
      """
             exist  cookbooks
            create  cookbooks/mylibrary/definitions/helper1.rb
      """
  
  Scenario: Generate a recipe that already exists
    When I run local executable "ey-recipes" with arguments "definition mylibrary helper1"
    When I run local executable "ey-recipes" with arguments "definition mylibrary helper2"
    And file "cookbooks/mylibrary/definitions/helper2.rb" contains "define :helper2 do"
    And I should see exactly
      """
             exist  cookbooks
            create  cookbooks/mylibrary/definitions/helper2.rb
      """
  
  Scenario: Generate a new recipe into local folder instead of in cookbooks/
    When I run local executable "ey-recipes" with arguments "definition mylibrary helper1 --local"
    And file "mylibrary/definitions/helper1.rb" is created
    And file "mylibrary/definitions/helper1.rb" contains "define :helper1 do"
    And I should see exactly
      """
             exist  
            create  mylibrary/definitions/helper1.rb
      """

