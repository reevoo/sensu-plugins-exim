# Sensu Plugin for Exim

[![Gem Version](https://badge.fury.io/rb/sensu-plugins-exim.svg)](https://badge.fury.io/rb/sensu-plugins-exim)
[![Build Status](https://travis-ci.org/reevoo/sensu-plugins-exim.svg?branch=master)](https://travis-ci.org/reevoo/sensu-plugins-exim)

## Functionality
Checks the exim queue length

### Files
bin/check-exim-queue.rb

## Installation

[Installation and Setup](http://sensu-plugins.io/docs/installation_instructions.html)

## Usage

```
./check-exim-queue.rb [-p path_to_exim] -w warn -c crit
./check-exim-queue.rb -w 500 -c 1000
./check-exim-queue.rb -p /usr/local/bin/exim -w 500 -c 1000
```

## Notes

* Path to exim defaults to `/usr/sbin/exim`
* On most systems sudo will be needed, eg:
`/etc/sudoers.d/sensu-exim-check`
```
sensu  ALL=(root) NOPASSWD:/opt/sensu/embedded/bin/check-exim-queue.rb
```
