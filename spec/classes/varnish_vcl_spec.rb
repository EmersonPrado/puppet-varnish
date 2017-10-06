require 'spec_helper'

# TODO: add more sophisticated tests, but for
# now you can't rspec concat content

describe 'varnish::vcl', :type => :class do

  context "default values" do
    let :facts do
      {
        :concat_basedir            => '/dne',
        :osfamily                  => 'Debian',
        :operatingsystem           => 'Debian',
        :operatingsystemrelease    => '7.0',
        :operatingsystemmajrelease => '7',
        :init_system               => 'init',
        :selinux                   => false,
        :architecture              => 'x86_64',
      }
    end

    it { should compile }
    it { should contain_class('varnish') }
    it { should contain_file('varnish-vcl').with(
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0644',
      'require' => 'Package[varnish]',
      'notify'  => 'Service[varnish]'
      )
    }
  end

end
