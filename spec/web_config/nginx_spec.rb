require 'configspec_helper'

describe package('nginx') do
  it { should be_installed }
end
