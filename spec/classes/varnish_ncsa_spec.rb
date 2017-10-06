require 'spec_helper'

describe 'varnish::ncsa', :type => :class do
  let :pre_condition do
    'include varnish'
  end

  let(:facts) do {
    :osfamily                  => 'Debian',
    :operatingsystem           => 'Debian',
    :operatingsystemrelease    => '7.0',
    :operatingsystemmajrelease => '7',
    :init_system               => 'init',
    :selinux                   => false,
    :architecture              => 'x86_64',
  } end

  context 'default values' do
    it { should compile }

    it { should contain_file('/etc/default/varnishncsa').with(
      'ensure'  => 'file',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0644',
      'notify'  => 'Service[varnishncsa]'
      )
    }
    it { should contain_file('/etc/default/varnishncsa').with_content(/VARNISHNCSA_ENABLED=1/) }
    it { should contain_file('/etc/default/varnishncsa').without_content(/DAEMON_OPTS/) }

    it { should contain_service('varnishncsa').with(
      'ensure'    => 'running',
      'require'   => 'Service[varnish]',
      'subscribe' => 'File[/etc/default/varnishncsa]'
      )
    }
  end

  context 'with enable false' do
    let(:params) { { :enable => false } }
    it { should contain_file('/etc/default/varnishncsa').with_content(/# VARNISHNCSA_ENABLED=1/) }
    it { should contain_service('varnishncsa').with('ensure' => 'stopped') }
  end

end
