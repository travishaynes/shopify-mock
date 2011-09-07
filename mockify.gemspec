# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mockify/version"

Gem::Specification.new do |s|
  s.name        = "mockify"
  s.version     = Mockify::VERSION
  s.authors     = ["Travis Haynes"]
  s.email       = ["travis.j.haynes@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "mockify"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency("fakeweb", [">= 1.3.0"])
end
