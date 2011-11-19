Feature: Wrap SM framework extension
  I want to write my customizations in SM framework extensions
  And have them work on EY Cloud
  
  @wip
  Scenario: Wrap a 
    When I run local executable "ey-recipes" with arguments "sm https://github.com/eystacks/sm_jenkins.git install configure start" 
    And I should see exactly
      """
             exist  cookbooks
            create  cookbooks/sm_jenkins/recipes/default.rb
            create  cookbooks/sm_jenkins/recipes/install.rb
            create  cookbooks/sm_jenkins/recipes/configure.rb
            create  cookbooks/sm_jenkins/recipes/start.rb
            append  cookbooks/main/recipes/default.rb
      """
