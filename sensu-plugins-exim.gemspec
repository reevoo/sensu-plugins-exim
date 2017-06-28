lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'
require 'sensu-plugins-exim/version'

Gem::Specification.new do |s|
  s.authors                = ['Ed Robinson']

  s.date                   = Date.today.to_s
  s.description            = 'This plugin provides exim queue' \
                             'monitoring and metrics collection'
  s.email                  = 'ed@reevoo.com'
  s.executables = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  s.files                  = Dir.glob('{bin,lib}/**/*') + %w(LICENSE README.md)
  s.homepage               = 'https://github.com/reevoo/sensu-plugins-exim'
  s.license                = 'MIT'
  s.metadata               = { 'maintainer'         => 'reevoo',
                               'development_status' => 'active',
                               'production_status'  => 'unstable',
                               'release_draft'      => 'false',
                               'release_prerelease' => 'false' }
  s.name                   = 'sensu-plugins-exim'
  s.platform               = Gem::Platform::RUBY
  s.post_install_message   = 'You can use the embedded Ruby by setting' \
                             'EMBEDDED_RUBY=true in /etc/default/sensu'
  s.require_paths          = ['lib']
  s.required_ruby_version  = '>= 2.0.0'
  s.summary                = 'Sensu plugins for exim'
  s.test_files             = s.files.grep(%r{^(test|spec|features)/})
  s.version                = SensuPluginsExim::Version::VER_STRING

  s.add_runtime_dependency 'sensu-plugin', '~> 1.2'

  s.add_development_dependency 'bundler',                   '~> 1.7'
  s.add_development_dependency 'rake',                      '~> 10.0'
  s.add_development_dependency 'rubocop',                   '~> 0.40.0'
end
