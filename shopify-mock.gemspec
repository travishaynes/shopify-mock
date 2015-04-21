# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shopify-mock/version'

Gem::Specification.new do |s|
  s.name = 'shopify-mock'
  s.version = ShopifyAPI::Mock::VERSION
  s.authors = ['Travis Haynes']
  s.email = ['travis.j.haynes@gmail.com']
  s.homepage = 'https://github.com/travishaynes/shopify-mock'
  s.summary = %q{Serves Shopify resources via FakeWeb for easily testing Shopify apps.}
  s.description = %q{This gem is used for testing Shopify apps without having to actually connect to
Shopify to develop the application.

You can use this gem explicitely for testing, or you can also use it in your
development environment to speed things up when fiddling around in the web
browser, or in the console.}

  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = %w{lib}

  s.add_dependency 'rake'
  s.add_dependency 'shopify_api', '= 3.2.7'

  s.add_development_dependency 'minitest', '= 5.6.0'
  s.add_development_dependency 'byebug', '~> 4.0.5'
end
