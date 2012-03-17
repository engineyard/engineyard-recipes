Feature: Generate recipe gem
  I want to create a new recipe
  And distribute it as a gem
  
  Scenario: Generate a new recipe
    When I run local executable "ey-recipes" with arguments "gem new_thing"
    And I should see exactly
      """
            create  eycloud-recipe-new_thing
            create  eycloud-recipe-new_thing/eycloud-recipe-new_thing.gemspec
            create  eycloud-recipe-new_thing/.gitignore
            create  eycloud-recipe-new_thing/ChangeLog.md
            create  eycloud-recipe-new_thing/Gemfile
            create  eycloud-recipe-new_thing/README.md
            create  eycloud-recipe-new_thing/Rakefile
             exist  eycloud-recipe-new_thing
            create  eycloud-recipe-new_thing/new_thing/recipes/default.rb
            create  eycloud-recipe-new_thing/metadata.json
            create  eycloud-recipe-new_thing/metadata.rb
      """
  
  
  
  
