# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "boat/version"

Gem::Specification.new do |s|
  s.name        = "boat"
  s.version     = Boat::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John E. Vincent"]
  s.email       = ["lusis.org+github.com@gmail.com"]
  s.homepage    = "https://github.com/lusis/Noah"
  s.summary     = %q{API and command-lind client for Noah}
  s.description = %q{Client library and command-line client for the Noah REST(ish) API}

  s.rubyforge_project = "boat"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("httparty", ["= 0.7.7"])
#  s.add_dependency("hashie", ["= 1.0.0"])
end
