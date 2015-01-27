# -*- encoding: utf-8 -*-
require File.expand_path('../lib/data_mapper/timestamps/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "dm-timestamps"
  gem.version       = DataMapper::Timestamps::VERSION

  gem.authors     = [ 'Foy Savas', 'Dan Kubb' ]
  gem.email       = [ "dan.kubb@gmail.com" ]
  gem.summary     = "DataMapper plugin for magical timestamps"
  gem.description = gem.summary
  gem.homepage    = "http://datamapper.org"
  gem.license     = 'MIT'

  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- {spec}/*`.split("\n")
  gem.extra_rdoc_files = %w[LICENSE README.rdoc]
  gem.require_paths = [ "lib" ]

  gem.add_runtime_dependency 'dm-core', '~> 1.2'

  gem.add_development_dependency 'rake',  '~> 0.9'
  gem.add_development_dependency 'rspec', '~> 1.3'
end

