# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "gitsy"
  gem.version       = "0.0.1"
  gem.authors       = ["Manoj", "Jaja"]
  gem.email         = ["m@noj.cc", "jbussdieker@gmail.com"]
  gem.summary       = %q{Simple git server.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)

  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
end

