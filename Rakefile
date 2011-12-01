require "bundler/gem_tasks"

require 'rspec/core/rake_task'

desc "Run all examples"
RSpec::Core::RakeTask.new

namespace :cucumber do
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:wip, 'Run features that are being worked on') do |t|
    t.cucumber_opts = "--tags @wip"
  end
  Cucumber::Rake::Task.new(:ok, 'Run features that should be working') do |t|
    t.cucumber_opts = "--tags ~@wip"
  end
  task :all => [:ok, :wip]
end

desc "Go to TravisCI status page"
task :travis do
  require "launchy"
  Launchy.open("http://travis-ci.org/#!/engineyard/engineyard-recipes")
end
desc 'Alias for cucumber:ok'
task :cucumber => 'cucumber:ok'

task :default => ["spec", "cucumber"]

desc "Generate list of zoneinfo"
task :zoneinfo do
  zonefile = File.expand_path("../lib/engineyard-recipes/zonefiles", __FILE__)
  FileUtils.chdir("/usr/share/zoneinfo") do
    File.open(zonefile, "w") do |file|
      file << Dir['**/*'].join("\n")
    end
  end
end
