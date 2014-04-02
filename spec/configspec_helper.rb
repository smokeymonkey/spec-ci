require 'configspec'
require 'net/ssh'
require 'net/scp'

include SpecInfra::Helper::Ssh
include SpecInfra::Helper::RedHat

RSpec.configure do |c|
  c.sudo_password = ''
  c.host  = ENV['TARGET_HOST']
  options = Net::SSH::Config.for(c.host)
  user    = options[:user] || Etc.getlogin
  c.ssh   = Net::SSH.start(c.host, user, options)
  c.scp   = Net::SCP.start(c.host, user, options)
end
