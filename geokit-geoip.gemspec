# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name = 'geokit-geoip'
  s.version = '0.1.0'

  s.authors = ["Aaron Suggs"]
  s.description = "Our GeoKit module for using a local (proprietary) Maxmind GeoIP database"
  s.email = "aaron@kickstarter.com"
  s.required_rubygems_version = ">= 1.5.0"

  s.files = Dir.glob("{bin,data,lib}/**/*") + %w(README.md Rakefile)
  s.homepage = 'http://github.com/kickstarter/geokit-geoip'
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary = %q{GeoKit module for GeoIP}
  s.test_files = Dir.glob("test/**/*")

  s.add_dependency 'geoip'
  s.add_dependency 'geokit', '>= 1.5.0' # What we're using on kickstarter at the moment
  s.add_development_dependency 'rake'
  s.add_development_dependency 'shoulda'
end
