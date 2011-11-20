Given /^I mock out git commands$/ do
  git_bin_path = File.expand_path('../../../fixtures/git-bin', __FILE__)
  ENV['PATH'] = git_bin_path + ":" + ENV['PATH']
end

Then /^git command "([^"]*)" is run$/ do |command|
  in_tmp_folder do
    File.should be_exists('git.log')
    File.read('git.log').should =~ /^#{command}$/
  end
end

