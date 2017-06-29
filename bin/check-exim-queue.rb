#!/usr/bin/env ruby
#
#   check-exim-queue
#
# DESCRIPTION:
#   Check the size of the Exim mail queue
#
# OUTPUT:
#   Plain text
#
# PLATFORMS:
#   Linux; any platform with Exim and Sensu
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   ./check-exim-queue.rb [-p path_to_exim] -w warn -c crit
#   ./check-exim-queue.rb -w 500 -c 1000
#   ./check-exim-queue.rb -p /usr/local/bin/exim -w 500 -c 1000

require 'sensu-plugin/check/cli'
require 'open3'

module SensuPluginsExim
  # Check the size of the Exim mail queue
  class CheckCLI < Sensu::Plugin::Check::CLI
    option :path,
           short: '-p EXIM_PATH',
           long: '--path EXIM_PATH',
           description: 'Path to the exim binary.  Defaults to /usr/sbin/exim',
           default: '/usr/sbin/exim'

    option :warning,
           short: '-w WARN_NUM',
           long: '--warnnum WARN_NUM',
           description: 'Number of messages in the queue' \
                        'considered to be a warning',
           required: true

    option :critical,
           short: '-c CRIT_NUM',
           long: '--critnum CRIT_NUM',
           description: 'Number of messages in the queue' \
                         'considered to be critical',
           required: true
    def run
      critical(msg) if queue_size >= critical_size
      warning(msg)  if queue_size >= warning_size
      ok(msg)
    end

    private

    def msg
      "#{queue_size} messages in the exim queue"
    end

    def queue_size
      @_queue_size ||= check_queue
    end

    def check_queue
      out, status = Open3.capture2e("#{config[:path]} -bpc")
      return out.chomp.to_i if status.success?
      unknown(out)
    end

    def critical_size
      config[:critical].to_i
    end

    def warning_size
      config[:warning].to_i
    end
  end
end
