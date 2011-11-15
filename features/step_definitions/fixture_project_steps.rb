Given /^I am in the "([^\"]*)" project folder$/ do |project|
  project_folder = File.expand_path(File.join(@fixtures_path, "projects", project))
  in_tmp_folder do
    FileUtils.cp_r(project_folder, project)
    setup_active_project_folder(project)
  end
end

Given /^I am have a local recipe "([^\"]*)" at "\/tmp\/ey-recipes\/([^"]*)"$/ do |name, repeat_name|
  name.should == repeat_name
  # TODO - path must start with /tmp to be safe and global
  # Copy fixtures/recipes/#{name} to /tmp/#{name}
end
