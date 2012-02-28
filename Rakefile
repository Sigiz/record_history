require "bundler/gem_tasks"
require 'bundler'
require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'factory_girl'

require 'yard'
YARD::Rake::YardocTask.new

namespace :spec do
  desc "Run unit specs"
  RSpec::Core::RakeTask.new('unit') do |t|
    t.pattern = 'spec/*_spec.rb'
  end
end

desc "Run the unit and acceptance specs"
task :spec => ['spec:unit']

