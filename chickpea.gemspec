lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chickpea/version'

Gem::Specification.new do |spec|
  spec.name          = 'chickpea'
  spec.version       = Chickpea::VERSION
  spec.authors       = ['Stone Tickle']
  spec.email         = ['lattis@mochiro.moe']

  spec.summary       = 'A simple stash'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'benchmark-ips'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'simplecov'
end
