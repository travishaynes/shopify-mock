# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "shopify-mock"
  s.version     = "0.1.2"
  s.authors     = ["Travis Haynes"]
  s.email       = ["travis.j.haynes@gmail.com"]
  s.homepage    = "https://github.com/travishaynes/shopify-mock"
  s.summary     = %q{Serves Shopify resources via FakeWeb for easily testing Shopify apps.}
  s.description = %q{This gem is used for testing Shopify apps without having to actually connect to
Shopify to develop the application.

You can use this gem explicitely for testing, or you can also use it in your
development environment to speed things up when fiddling around in the web
browser, or in the console.}

  s.rubyforge_project = "shopify-mock"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency("fakeweb", [">= 1.3.0"])
  s.add_dependency("rspec", [">= 2.6.0"])
  s.add_dependency("rake", [">= 0.8.7"])
  s.add_dependency("shopify_api", [">= 1.2.5"])
  s.add_dependency("activesupport", [">= 3.0.0"])
  s.add_dependency("libxml-ruby", [">= 0.8.3"])
end
