Feature: Use recipe gem
  I want to use a recipe/component/thing by pointing to a gem or git repo

  Background:
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init -d"

  Scenario: Use a recipe gem and it is installed into the target app
    When I run local executable "ey-recipes" with arguments "use eycloud-recipe-resque"
    And file "Gemfile" contains "gem 'eycloud-recipe-resque', :group => :eycloud"
    And file "deploy/cookbooks/main/recipes/default.rb" contains "require_recipe 'eycloud-recipe-resque'"
    And file "deploy/before_restart.rb" contains "on_utilities(:resque) do"
    
  Scenario: Use a recipe git repo and it is installed into the target app
    When I run local executable "ey-recipes" with arguments "use git://github.com/engineyard/eycloud-recipe-resque.git"
    And file "Gemfile" contains "gem 'eycloud-recipe-resque', :group => :eycloud, :git => 'git://github.com/engineyard/eycloud-recipe-resque.git'"
    And file "deploy/cookbooks/main/recipes/default.rb" contains "require_recipe 'simple-recipe-gem'"
    And file "deploy/before_restart.rb" contains "on_utilities(:resque) do"

  
  
