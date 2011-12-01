Feature: Generic command runner
  I want a command to be run
  And monit to ensure it keeps running
  
  Background:
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init"

  @wip
  Scenario: Wrap a command with explicit app name
    When I run local executable "ey-recipes" with arguments "command java-main 'java com.thingy.Main' -a app_name"
    Then file "cookbooks/java-main/recipes/default.rb" contains "command_name = 'java-main'"
    And file "cookbooks/java-main/recipes/default.rb" contains "command_to_run = 'java com.thingy.Main'"
    And file "cookbooks/java-main/recipes/default.rb" contains "app_name = 'app_name'"
    And file "cookbooks/main/recipes/default.rb" contains "require_recipe 'java-main'"
    And I should see exactly
      """
             exist  cookbooks
            create  cookbooks/java-main/recipes/default.rb
            create  cookbooks/java-main/templates/default/monitrc.erb
            create  cookbooks/java-main/templates/default/wrapper.sh.erb
            append  cookbooks/main/recipes/default.rb
      """

  @wip
  Scenario: Wrap a command and auto-detect app name from current project
    Given the project is registered as an EY Cloud "my_rails_app"
    When I run local executable "ey-recipes" with arguments "command java-main 'java com.thingy.Main'"
    And file "cookbooks/java-main/recipes/default.rb" contains "app_name = 'my_rails_app'"
