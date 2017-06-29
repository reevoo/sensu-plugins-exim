require 'spec_helper'

RSpec.describe 'check-exim-queue.rb', type: :aruba do
  let(:bindir) { File.join(File.dirname(__FILE__), 'support', 'bin') }
  before(:each) { run("check-exim-queue.rb #{args}") }

  context 'no args' do
    let(:args) { '' }

    it 'fails' do
      expect(last_command_started).to_not be_successfully_executed
      expect(last_command_started).to have_output(/You must supply -w/)
    end
  end

  context 'critical queue size' do
    let(:args) { "-w 5 -c 10 -p #{bindir}/10" }

    it 'returns a critical error' do
      expect(last_command_started).to_not be_successfully_executed
      expect(last_command_started.exit_status).to be 2
      expect(last_command_started).to have_output(
        'SensuPluginsExim::CheckCLI CRITICAL: 10 messages in the exim queue'
      )
    end
  end

  context 'warning queue size' do
    let(:args) { "-w 10 -c 20 -p #{bindir}/10" }

    it 'returns a warning' do
      expect(last_command_started).to_not be_successfully_executed
      expect(last_command_started.exit_status).to be 1
      expect(last_command_started).to have_output(
        'SensuPluginsExim::CheckCLI WARNING: 10 messages in the exim queue'
      )
    end
  end

  context 'normal queue size' do
    let(:args) { "-w 11 -c 15 -p #{bindir}/10" }

    it 'returns a warning' do
      expect(last_command_started).to be_successfully_executed
      expect(last_command_started.exit_status).to be 0
      expect(last_command_started).to have_output(
        'SensuPluginsExim::CheckCLI OK: 10 messages in the exim queue'
      )
    end
  end

  context 'permission error' do
    let(:args) { "-w 11 -c 15 -p #{bindir}/permission_err" }

    it 'returns a warning' do
      expect(last_command_started).to_not be_successfully_executed
      expect(last_command_started.exit_status).to be 2
      expect(last_command_started).to have_output(
        /Check failed to run: Permission denied/
      )
    end
  end
end
