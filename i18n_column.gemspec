# -*- encoding: utf-8 -*-
$:.push(File.expand_path('../lib', __FILE__))
require('i18n_column/version')

Gem::Specification.new do |s|
  s.name        = 'i18n_column'
  s.version     = I18nColumn::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Philipp Ullmann', 'René Groß']
  s.email       = 'philipp.ullmann@create.at'
  s.homepage    = 'http://github.com/create-philipp-ullmann/i18n_column'
  s.summary     = 'Storing and retrieving translations from a single database column'
  s.description = 'This extension provides the capabilities of storing and retrieving translations from a single database column. The translations are serialized using JSON.'

  s.rubyforge_project = "i18n_column"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  
  s.add_development_dependency('rspec', ['>= 2.6.0'])
  s.add_development_dependency('sqlite3', ['>= 1.3.4'])
  s.add_development_dependency('activerecord', ['>= 3.1.0'])
end
