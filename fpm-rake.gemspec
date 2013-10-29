# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fpm/rake/version'

Gem::Specification.new do |spec|
  spec.name          = "fpm-rake"
  spec.version       = FPM::Rake::VERSION
  spec.authors       = ["Josh Kline"]
  spec.email         = ["github.com@track.jonfram.net"]
  spec.description   = %q{
    Intalls a Rake task that uses Effing Package Manager (fpm)
    to generate some other package format from your gem.

    Assumes you already have a Rake task to build your gem.

    Currently supports only Red Har Package (RPM) format.
  }
  spec.summary       = %q{Rake tasks for building RPM packages with fpm}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
