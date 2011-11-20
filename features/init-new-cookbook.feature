Feature: Generate a new custom cookbook for your EY Cloud environments

  Scenario: Generate basic cookbook scaffold
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init"
    And file "cookbooks/main/recipes/default.rb" is created
    And file "cookbooks/main/libraries/ruby_block.rb" is created
    And I should see exactly
      """
            create  cookbooks
            create  cookbooks/main/attributes/recipe.rb
            create  cookbooks/main/definitions/ey_cloud_report.rb
            create  cookbooks/main/libraries/ruby_block.rb
            create  cookbooks/main/libraries/run_for_app.rb
            create  cookbooks/main/recipes/default.rb
      """
