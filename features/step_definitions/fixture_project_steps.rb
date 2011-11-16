Given /^I am in the "([^\"]*)" project folder$/ do |project|
  project_folder = File.expand_path(File.join(@fixtures_path, "projects", project))
  in_tmp_folder do
    FileUtils.cp_r(project_folder, project)
    setup_active_project_folder(project)
  end
end

Given /^I am have a local recipe "([^\"]*)" at "\/tmp\/ey-recipes\/([^"]*)"$/ do |name, repeat_name|
  name.should == repeat_name
  fixture_recipe = File.join(@fixtures_path, "recipes", name)
  FileUtils.rm_rf(@tmp_recipes_path)
  FileUtils.mkdir_p(@tmp_recipes_path)
  FileUtils.cp_r(fixture_recipe, @tmp_recipes_path)
end

Given /^I am have a local sm extension "([^"]*)" at "\/tmp\/ey-recipes\/([^"]*)"$/ do |name, repeat_name|
  name.should == repeat_name
  fixture_recipe = File.join(@fixtures_path, "sm_exts", name)
  FileUtils.rm_rf(@tmp_recipes_path)
  FileUtils.mkdir_p(@tmp_recipes_path)
  FileUtils.cp_r(fixture_recipe, @tmp_recipes_path)
  FileUtils.chdir(File.join(@tmp_recipes_path, name)) do
    `git init`
    `git add .`
    `git commit -m 'Ready for testing'`
  end
end

Given /^project is a git repository$/ do
  in_project_folder do
    `git init`
    `git add .`
    `git commit -m 'Ready for testing'`
  end

Given /^I have my environment booted or an EY Local VM running$/ do
  puts "No implemented"
end

Given /^I am expecting an eix portage search for "([^"]*)"$/ do |filter|
  # FIXME - currently a complete stubbing of the remote execution of `eix` calls & parsing of that output
  @packages = case filter
  when "redis"
    [
      { :recipe => 'dev-db/redis', :version => '1.0-r1!p' },
      { :recipe => 'dev-db/redis', :version => '1.01!p' },
      { :recipe => 'dev-db/redis', :version => '1.2.1!p' },
      { :recipe => 'dev-db/redis', :version => '1.2.2!p' },
      { :recipe => 'dev-db/redis', :version => '1.2.5!p' :unmasked => true },
      { :recipe => 'dev-db/redis', :version => '1.2.6!p' },
      { :recipe => 'dev-db/redis', :version => '1.3.7_pre1!p' :unmasked => true },
      { :recipe => 'dev-db/redis', :version => '1.3.12_pre1!p' :unmasked => true },
      { :recipe => 'dev-db/redis', :version => '2.0.1!p' :unmasked => true },
      { :recipe => 'dev-db/redis', :version => '2.0.2!p' :unmasked => true },
      { :recipe => 'dev-db/redis', :version => '2.0.4!p' :unmasked => true },
      { :recipe => 'dev-db/redis', :version => '2.2.4!p' :unmasked => true },
      { :recipe => 'dev-db/redis', :version => '2.2.11!p', :unmasked => true, :installed => true },
      { :recipe => 'dev-db/redis', :version => '2.4.0!p', :unmasked => true }
    ]
  when "gitosis"
    [
      { :recipe => 'dev-util/gitosis', :version => '0.2_p20080626' :unmasked => true },
      { :recipe => 'dev-util/gitosis', :version => '0.2_p20080825' :unmasked => true },
      { :recipe => 'dev-util/gitosis-gentoo', :version => '0.2_p20080825' :unmasked => true },
      { :recipe => 'dev-util/gitosis-gentoo', :version => '0.2_p20080711' :unmasked => true },
      { :recipe => 'dev-util/gitosis-gentoo', :version => '0.2_p20081028' :unmasked => true }
    ]
  when "virtual/mysql"
    [
      { :recipe => 'dev-util/mysql', :version => '4.0' },
      { :recipe => 'dev-util/mysql', :version => '4.1' },
      { :recipe => 'dev-util/mysql', :version => '5.0', :installed => true },
      { :recipe => 'dev-util/mysql', :version => '5.0[1]' },
      { :recipe => 'dev-util/mysql', :version => '5.1' :unmasked => true },
      { :recipe => 'dev-util/mysql', :version => '5.1[1]' :unmasked => true },
      { :recipe => 'dev-util/mysql', :version => '5.5[1]' :unmasked => true }
    ]
  else
    []
  end
end
