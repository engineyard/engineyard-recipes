Feature: Search portage
  I want to know what packages are available in EY Gentoo Portage
  And what version numbers they have
  
  Scenario: Ask for environment to be booted
    When I run local executable "ey-recipes" with arguments "portage redis"
    Then I should see exactly
      """
      ERROR: To search for portage packages we please need an environment to be selected and booted
      """    
  @wip
  Scenario: Show list of packages in portage with redis example
    When I run local executable "ey-recipes" with arguments "portage redis"
    Then I should see exactly
      """
      ey-recipes recipe redis -p 'dev-db/redis'	-v '1.0-r1!p'
      ey-recipes recipe redis -p 'dev-db/redis'	-v '1.01!p'
      ey-recipes recipe redis -p 'dev-db/redis'	-v '1.2.1!p'
      ey-recipes recipe redis -p 'dev-db/redis'	-v '1.2.2!p'
      ey-recipes recipe redis -p 'dev-db/redis'	-v '1.2.5!p' -u
      ey-recipes recipe redis -p 'dev-db/redis'	-v '1.2.6!p'
      ey-recipes recipe redis -p 'dev-db/redis'	-v '1.3.7_pre1!p' -u
      ey-recipes recipe redis -p 'dev-db/redis'	-v '1.3.12_pre1!p' -u
      ey-recipes recipe redis -p 'dev-db/redis'	-v '2.0.1!p' -u
      ey-recipes recipe redis -p 'dev-db/redis'	-v '2.0.2!p' -u
      ey-recipes recipe redis -p 'dev-db/redis'	-v '2.0.4!p' -u
      ey-recipes recipe redis -p 'dev-db/redis'	-v '2.2.4!p' -u
      ey-recipes recipe redis -p 'dev-db/redis'	-v '2.2.11!p' -u # already installed
      ey-recipes recipe redis -p 'dev-db/redis'	-v '2.4.0!p' -u
      """

  @wip
  Scenario: Show list of packages in portage with gitosis example
    Given I have my environment booted or an EY Local VM running
    And I am expecting an eix portage search for "redis"
    When I run local executable "ey-recipes" with arguments "portage gitosis"
    Then I should see exactly
      """
      ey-recipes recipe gitosis -p 'dev-util/gitosis' -v '0.2_p20080626' -u
      ey-recipes recipe gitosis -p 'dev-util/gitosis' -v '0.2_p20080825' -u
      ey-recipes recipe gitosis -p 'dev-util/gitosis-gentoo' -v '0.2_p20080825' -u
      ey-recipes recipe gitosis -p 'dev-util/gitosis-gentoo' -v '0.2_p20080711' -u
      ey-recipes recipe gitosis -p 'dev-util/gitosis-gentoo' -v '0.2_p20081028' -u
      """

  @wip
  Scenario: Searching full portage name still gives simple recipe package name
    Given I have my environment booted or an EY Local VM running
    And I am expecting an eix portage search for "virtual/mysql"
    When I run local executable "ey-recipes" with arguments "portage virtual/mysql"
    Then I should see exactly
      """
      ey-recipes recipe mysql -p 'dev-util/mysql' -v '4.0'
      ey-recipes recipe mysql -p 'dev-util/mysql' -v '4.1'
      ey-recipes recipe mysql -p 'dev-util/mysql' -v '5.0' # already installed
      ey-recipes recipe mysql -p 'dev-util/mysql' -v '5.0[1]'
      ey-recipes recipe mysql -p 'dev-util/mysql' -v '5.1' -u
      ey-recipes recipe mysql -p 'dev-util/mysql' -v '5.1[1]' -u
      ey-recipes recipe mysql -p 'dev-util/mysql' -v '5.5[1]' -u
      """
