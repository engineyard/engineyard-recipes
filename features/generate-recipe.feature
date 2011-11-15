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
  
  
  
  