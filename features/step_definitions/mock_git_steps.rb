require "engineyard-recipes/git_cmd"

Given /^I mock out git commands$/ do
  Engineyard::Recipes::GitCmd.test_mode = true
end

Then /^git command "([^"]*)" is run$/ do |command|
  command.gsub!(/^git\s+/, '') # don't test for git command portion
  in_tmp_folder do
    File.should be_exists('git.log')
    File.read('git.log').should =~ /^#{command}$/
  end
end


Then /^git command "([^"]*)" is not run$/ do |command|
  command.gsub!(/^git\s+/, '') # don't test for git command portion
  in_tmp_folder do
    if File.exists? 'git.log'
      File.read('git.log').should_not =~ /^#{command}$/
    end
  end
end

