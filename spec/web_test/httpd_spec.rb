require 'serverspec_helper'

describe package('httpd') do
  it { should be_installed }
end
