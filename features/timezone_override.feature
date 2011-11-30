Feature: Timezone override
  I want a different timezone
  
  Background:
    Given I am in the "rails" project folder
    When I run local executable "ey-recipes" with arguments "init"
    
  Scenario: Set the timezone I want
    When I run local executable "ey-recipes" with arguments "timezone Australia/Tasmania"
    Then file "cookbooks/timezone-override/recipes/default.rb" contains
      """
      #
      # Cookbook Name:: timezone-override
      # Recipe:: default
      #

      # Note that this is for the Australia/Tasmania timezone. Look in
      # /usr/share/zoneinfo for your relevant file.
      service "vixie-cron"
      service "sysklogd"
      service "nginx"

      link "/etc/localtime" do
        to "/usr/share/zoneinfo/Australia/Tasmania"
        notifies :restart, resources(:service => ["vixie-cron", "sysklogd", "nginx"]), :delayed
        not_if "readlink /etc/localtime | grep -q 'Australia/Tasmania$'"
      end
      """
    And file "cookbooks/main/recipes/default.rb" contains "require_recipe 'timezone-override'"
    And I should see exactly
      """
             exist  cookbooks
            create  cookbooks/timezone-override/recipes/default.rb
            append  cookbooks/main/recipes/default.rb
      """
  