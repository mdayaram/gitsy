# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "gitsy"
  gem.version       = File.read("VERSION").strip
  gem.authors       = ["Noj", "Jaja"]
  gem.email         = ["m@noj.cc", "jbussdieker@gmail.com"]
  gem.license       = "MIT"
  gem.summary       = %q{Simple git server.}
  gem.description   = %q{Simple git server with command management.}
  gem.homepage      = "https://github.com/mdayaram/gitsy"

  gem.files         = `git ls-files`.split($/)

  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake', '~> 0.8'
end

