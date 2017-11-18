
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coincheck-api'

Gem::Specification.new do |spec|
  spec.name          = 'coincheck-api'
  spec.version       = Coincheck::API::VERSION
  spec.authors       = ['Masayuki Higashino']
  spec.email         = ["mh.on.web@gmail.com"]

  spec.summary       = %q{A client for Coincheck API.}
  spec.description   = %q{A client for Coincheck API.}
  spec.homepage      = 'https://github.com/mh61503891/coincheck-api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
