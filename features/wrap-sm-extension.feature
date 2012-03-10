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
    Then file "cookbooks/jenkins/recipes/install_sm_ext.rb" contains "command %(sm ext install jenkins #{node[:sm_jenkins_uri]})"
    Then file ".gitmodules" is not created
    And I should see exactly
      """
             exist  cookbooks
            create  cookbooks/jenkins/attributes/recipe.rb
            create  cookbooks/jenkins/recipes/default.rb
            create  cookbooks/jenkins/recipes/install_sm_ext.rb
            append  cookbooks/main/recipes/default.rb
      """

  Scenario: Wrap an SM extension only and trigger its commands
    When I run local executable "ey-recipes" with arguments "sm https://github.com/eystacks/sm_jenkins.git install configure start --name jenkins"
    Then file "cookbooks/jenkins/recipes/default.rb" contains "require_recipe 'jenkins::install_sm_ext'"
    Then file "cookbooks/jenkins/recipes/default.rb" contains "require_recipe 'jenkins::install'"
    Then file "cookbooks/jenkins/recipes/default.rb" contains "require_recipe 'jenkins::configure'"
    Then file "cookbooks/jenkins/recipes/default.rb" contains "require_recipe 'jenkins::start'"
    Then file "cookbooks/jenkins/recipes/install.rb" contains "command %(sm jenkins install)"
    Then file "cookbooks/jenkins/recipes/configure.rb" contains "command %(sm jenkins configure)"
    Then file "cookbooks/jenkins/recipes/start.rb" contains "command %(sm jenkins start)"
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

  Scenario: Wrap a local SM extension and vendor it
    Given project is a git repository
    And I am have a local sm extension "local_sm_repo" at "/tmp/ey-recipes/local_sm_repo"
    When I run local executable "ey-recipes" with arguments "sm /tmp/ey-recipes/local_sm_repo --name jenkins --submodule" 
    Then file "cookbooks/jenkins/attributes/recipe.rb" contains "sm_jenkins_uri(File.expand_path('../../repo', __FILE__))"
    And git command "git submodule add https://github.com/eystacks/sm_jenkins.git cookbooks/jenkins/repo" is not run
    And file "cookbooks/jenkins/repo/local_sm_repo_readme.md" is created

  Scenario: Wrap a git SM extension and vendor it via submodules
    Given project is a git repository
    And I mock out git commands
    When I run local executable "ey-recipes" with arguments "sm https://github.com/eystacks/sm_jenkins.git --name jenkins --submodule" 
    Then file "cookbooks/jenkins/attributes/recipe.rb" contains "sm_jenkins_uri(File.expand_path('../../repo', __FILE__))"
    And git command "git submodule add https://github.com/eystacks/sm_jenkins.git cookbooks/jenkins/repo" is run
    
  Scenario: Wrap a git SM extension and vendor it via submodules for chef-on-deploy
    When I run local executable "ey-recipes" with arguments "init -d"
    When I run local executable "ey-recipes" with arguments "init-sm"
    Given project is a git repository
    And I mock out git commands
    When I run local executable "ey-recipes" with arguments "sm https://github.com/eystacks/sm_jenkins.git --name jenkins --submodule" 
    Then file "deploy/cookbooks/jenkins/attributes/recipe.rb" contains "sm_jenkins_uri(File.expand_path('../../repo', __FILE__))"
    And git command "git submodule add https://github.com/eystacks/sm_jenkins.git deploy/cookbooks/jenkins/repo" is run

  Scenario: Do not allow submodules flag if current project is not a git repo
    Given I mock out git commands
    When I run local executable "ey-recipes" with arguments "sm https://github.com/eystacks/sm_jenkins.git --name jenkins --submodule" 
    Then I should see exactly
      """
      ERROR: This project is not a git repository yet.
      """