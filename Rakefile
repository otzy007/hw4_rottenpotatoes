#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rottenpotatoes::Application.load_tasks

Rake::Task[:default].prerequisites.clear
task :default => [:spec]

task :travis do
  ["rspec spec", "rake cucumber"].each do |cmd|
    puts "Starting #{cmd} ..."
    system("bundle exec ${cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end