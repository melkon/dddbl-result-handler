# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dddbl-result-handler/version"

Gem::Specification.new do |s|
  s.name        = "dddbl-result-handler"
  s.version     = DDDBL::Result::Handler::VERSION
  s.authors     = ["André Gawron"]
  s.email       = ["andre@ziemek.de"]
  s.homepage    = "https://github.com/melkon/dddbl-result-handler"
  s.summary     = %q{Default Result Sets for the DDDBL}
  s.description = %q{This gem provides a default set of result handler for the dddbl, see: http://www.dddbl.de}
  s.license     = 'BSD'

  s.rubyforge_project = "dddbl-result-handler"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.require_paths = ["lib"]

  s.requirements << "FYI: RDBI <= 0.9.1 is incompatible, use their github master branch instead"

  s.add_runtime_dependency "dddbl"

  s.add_development_dependency "test-unit"
  s.add_development_dependency "rdbi-driver-mock"
end
