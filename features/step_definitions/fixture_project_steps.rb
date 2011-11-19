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
