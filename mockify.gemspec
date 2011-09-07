# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mockify/version"

Gem::Specification.new do |s|
  s.name        = "mockify"
  s.version     = Mockify::VERSION
  s.authors     = ["Travis Haynes"]
  s.email       = ["travis.j.haynes@gmail.com"]
  s.homepage    = "https://github.com/travishaynes/mockify"
  s.summary     = %q{Serves Shopify resources via FakeWeb for easily testing Shopify apps.}
  s.description = %q{This gem is used for testing Shopify apps without having to actually connect to
Shopify to develop the application.

You can use this gem explicitely for testing, or you can also use it in your
development environment to speed things up when fiddling around in the web
browser, or in the console.}

  s.rubyforge_project = "mockify"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency("fakeweb", [">= 1.3.0"])
end
