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

  Scenario: Run cookbooks during deployments
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init -d"
    And file "deploy/before_migrate.rb" is created
    And file "deploy/cookbooks/main/recipes/default.rb" is created
    And I should see exactly
      """
            create  deploy
            create  deploy/before_migrate.rb
            create  deploy/solo.rb
            create  deploy/cookbooks
            create  deploy/cookbooks/main/attributes/recipe.rb
            create  deploy/cookbooks/main/definitions/ey_cloud_report.rb
            create  deploy/cookbooks/main/libraries/ruby_block.rb
            create  deploy/cookbooks/main/libraries/run_for_app.rb
            create  deploy/cookbooks/main/recipes/default.rb
      """

  # TODO - make --on-deploy the default
  # TODO - include emerge definitions
  Scenario: Cookbooks use modern chef
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init --chef -d"
    Then file "deploy/before_migrate.rb" contains
      """
      # Set up a chef 0.10 dna.json file (for stack-v1 + stack-v2)
      # TODO does this run on non-app-master/solo?
      custom_json = node.dup
      custom_json['run_list'] = 'recipe[main]'
      File.open("/etc/chef-custom/dna.json", 'w') do |f|
        f.puts JSON.pretty_generate(custom_json)
        f.chmod(0600)
      end

      # Runs application cookbooks
      run "cd #{latest_release}; sudo bundle exec chef-solo -c #{latest_release}/deploy/solo.rb -j /etc/chef-custom/dna.json"
      
      """
    And I should see exactly
      """
            create  deploy
            create  deploy/before_migrate.rb
            create  deploy/solo.rb
            create  deploy/cookbooks
            create  deploy/cookbooks/main/recipes/default.rb
            append  Gemfile
      """
  