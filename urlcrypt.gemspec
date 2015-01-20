# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "urlcrypt"
  s.version     = "0.1.1"
  s.authors     = "Thomas Fuchs, Samuel Tesla"
  s.summary     = %q{encrypts strings in URL-friendly format}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
end
