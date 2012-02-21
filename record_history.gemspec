# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "record_history/version"

Gem::Specification.new do |s|
  s.name        = "record_history"
  s.version     = RecordHistory::VERSION
  s.authors     = ["Mikhail Gulin"]
  s.email       = ["m.gulin@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{ActiveRecord versioning}
  s.description = %q{ActiveRecord versioning}

  s.rubyforge_project = "record_history"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_development_dependency "yard", "~> 0.7.5"
  s.add_development_dependency "redcarpet", "~> 1.17"
  # s.add_runtime_dependency "rest-client"
end
