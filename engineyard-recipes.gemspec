# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "engineyard-recipes/version"

Gem::Specification.new do |s|
  s.name        = "engineyard-recipes"
  s.version     = Engineyard::Recipes::VERSION
  s.authors     = ["Dr Nic Williams"]
  s.email       = ["drnicwilliams@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Tools to generate, upload, test and apply chef recipes for Engine Yard Cloud.}
  s.description = %q{Tools to generate, upload, test and apply chef recipes for Engine Yard Cloud.}

  s.rubyforge_project = "engineyard-recipes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("thor", ["~> 0.14.6"])
  s.add_dependency("engineyard", ["~> 1.4.6"])

  s.add_development_dependency("rake", ["~> 0.9.2"])
  s.add_development_dependency("cucumber", ["~> 1.1.2"])
  s.add_development_dependency("rspec", ["~> 2.7.0"])
  s.add_development_dependency("launchy")
  # s.add_development_dependency("json")
  # s.add_development_dependency("awesome_print")
  # s.add_development_dependency("realweb", '~>0.1.6')
  # s.add_development_dependency("open4")
  # s.add_development_dependency("sinatra")
  # s.add_development_dependency("fakeweb", "~>1.3.0")
end
