require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :bench do
  sh "bundle exec ruby spec/benchmark.rb"
end
