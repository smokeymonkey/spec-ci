require 'rake'
require 'rspec/core/rake_task'
require 'docker'
 
hosts = [
  {
    :name  => 'docker',
    :roles => %w( web ),
    :image => 'local/amznssh'
  }
]
 
hosts = hosts.map do |host|
  {
    :name       => host[:name],
    :short_name => host[:name].split('.')[0],
    :roles      => host[:roles],
    :image      => host[:image],
  }
end
 
desc "Run serverspec to all hosts"
task :default do
  Rake::Task['spec:all'].invoke
end
 
namespace :spec do
  task :all => hosts.map {|h| 'spec:' + h[:short_name] }
  hosts.each do |host|
    container = Docker::Container.create(
      'Cmd'          => ['/usr/sbin/sshd', '-D'],
      'Image'        => host[:image],
      'PortSpecs'    => '22'
    )
    container.start(
      'PortBindings' => {
        '22/tcp' => [
          {'HostIp' => '0.0.0.0'},
          {'HostPort' => '54322'}
        ]
      }
    )
    sleep 1

    desc "Run spec to #{host[:name]}"
    ENV['TARGET_HOST'] = host[:name]

    # configspec
    RSpec::Core::RakeTask.new(host[:short_name].to_sym) do |t|
      t.pattern = 'spec/{' + host[:roles].join(',') + '}_config/*_spec.rb'
    end

    # serverspec
    RSpec::Core::RakeTask.new(host[:short_name].to_sym) do |t|
      t.pattern = 'spec/{' + host[:roles].join(',') + '}_test/*_spec.rb'
    end
    container.stop

  end
end
