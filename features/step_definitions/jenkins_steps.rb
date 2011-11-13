Given /^I want to fake out the boot sequence of Recipes$/ do
  base_path = File.join(File.dirname(__FILE__) + "/../../fixtures/Recipes_boot_sequence/")
  FakeWeb.register_uri(:get, "http://app-master-hostname.compute-1.amazonaws.com/", [
    {:body => File.read(base_path + "pre_Recipes_booting.html")},
    {:body => File.read(base_path + "Recipes_booting.html")},
    {:body => File.read(base_path + "Recipes_ready.html")}
  ])
end

Given /^I have public key "([^"]*)" on host "([^"]*)"$/ do |public_key_value, host|
  mock_target = File.expand_path("../../../tmp/scp_mock", __FILE__)
  File.open(mock_target, "w") { |file| file << public_key_value }
end

Given /^I set "([^"]*)" as the default Recipes server$/ do |host|
  require "Recipes"
  require "Recipes/config"
  Recipes::Api.setup_base_url(:host => host, :port => 80)
  Recipes::Api.send(:cache_base_uri)
end

