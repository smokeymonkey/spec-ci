require 'rake'
require 'rspec/core/rake_task'
 
hosts = [
  {
    :name  => 'docker',
    :roles => %w( web )
  }
]
 
hosts = hosts.map do |host|
  {
    :name       => host[:name],
    :short_name => host[:name].split('.')[0],
    :roles      => host[:roles],
  }
end
 
desc "Run serverspec to all hosts"
task :configspec => 'configspec:all'
task :serverspec => 'serverspec:all'
task :all do
   Rake::Task['configspec:all'].invoke
   Rake::Task['serverspec:all'].invoke
end
 
namespace :configspec do
  task :all => hosts.map {|h| 'configspec:' + h[:short_name] }
  hosts.each do |host|
    desc "Run configspec to #{host[:name]}"
    RSpec::Core::RakeTask.new(host[:short_name].to_sym) do |t|
      ENV['TARGET_HOST'] = host[:name]
      t.pattern = 'spec/{' + host[:roles].join(',') + '}_config/*_spec.rb'
    end
  end
end

namespace :serverspec do
  task :all => hosts.map {|h| 'serverspec:' + h[:short_name] }
  hosts.each do |host|
    desc "Run serverspec to #{host[:name]}"
    RSpec::Core::RakeTask.new(host[:short_name].to_sym) do |t|
      ENV['TARGET_HOST'] = host[:name]
      t.pattern = 'spec/{' + host[:roles].join(',') + '}_test/*_spec.rb'
    end
  end
end

