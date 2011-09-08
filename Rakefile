require 'bundler/gem_tasks'

task :default => [:spec]

desc "runs all specs"
task :spec do
  files = Dir[File.expand_path("../spec/**/*_spec.rb", __FILE__)].join(" ")
  puts files
  exec "bundle exec rspec #{files}"
end
