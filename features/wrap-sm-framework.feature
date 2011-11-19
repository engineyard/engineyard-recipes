Feature: Wrap SM framework extension
  I want to write my customizations in SM framework extensions
  And have them work on EY Cloud
  
  Background:
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init"
    When I run local executable "ey-recipes" with arguments "init-sm"

  Scenario: Wrap an SM extension only
    When I run local executable "ey-recipes" with arguments "sm https://github.com/eystacks/sm_jenkins.git --name jenkins" 
    Then file "cookbooks/jenkins/recipes/default.rb" contains "require_recipe 'jenkins::install_sm_ext'"
    Then file "cookbooks/jenkins/attributes/recipe.rb" contains "sm_jenkins_uri('https://github.com/eystacks/sm_jenkins.git')"
    Then file "cookbooks/jenkins/recipes/install_sm_ext.rb" contains "command 'sm ext install jenkins #{node[:sm_jenkins_uri]}'"
    And I should see exactly
      """
             exist  cookbooks
            create  cookbooks/jenkins/attributes/recipe.rb
            create  cookbooks/jenkins/recipes/default.rb
            create  cookbooks/jenkins/recipes/install_sm_ext.rb
            append  cookbooks/main/recipes/default.rb
      """

  @wip
  Scenario: Wrap an SM extension, vendor it as submodule, and trigger its commands
    When I run local executable "ey-recipes" with arguments "sm https://github.com/eystacks/sm_jenkins.git install configure start --name jenkins --submodule" 
    Then file "cookbooks/jenkins/recipes/default.rb" contains "require_recipe 'jenkins::install_sm_ext'"
    Then file "cookbooks/jenkins/recipes/default.rb" contains "require_recipe 'jenkins::install'"
    Then file "cookbooks/jenkins/recipes/default.rb" contains "require_recipe 'jenkins::configure'"
    Then file "cookbooks/jenkins/recipes/default.rb" contains "require_recipe 'jenkins::start'"
    Then file "cookbooks/jenkins/recipes/install_sm_ext.rb" contains "command 'sm ext install jenkins #{node[:sm_jenkins_uri]}'"
    Then file "cookbooks/jenkins/recipes/install.rb" contains "command 'sm jenkins install'"
    Then file "cookbooks/jenkins/recipes/configure.rb" contains "command 'sm jenkins configure'"
    Then file "cookbooks/jenkins/recipes/start.rb" contains "command 'sm jenkins start'"
    Then file "cookbooks/jenkins/attributes/recipe.rb" contains "sm_jenkins_uri(File.expand_path('../../repo', __FILE__))"
    And I should see exactly
      """
             exist  cookbooks
            create  cookbooks/jenkins/attributes/recipe.rb
            create  cookbooks/jenkins/recipes/default.rb
            create  cookbooks/jenkins/recipes/install_sm_ext.rb
            create  cookbooks/jenkins/recipes/install.rb
            create  cookbooks/jenkins/recipes/configure.rb
            create  cookbooks/jenkins/recipes/start.rb
            append  cookbooks/main/recipes/default.rb
      """
    Then file "cookbooks/sm_jenkins/repo/.git/config" contains "url = https://github.com/eystacks/sm_jenkins.git"
