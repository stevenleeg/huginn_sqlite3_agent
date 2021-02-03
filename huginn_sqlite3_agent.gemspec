# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "huginn_sqlite3_agent"
  spec.version       = '0.1.1'
  spec.authors       = ["Steve Gattuso"]
  spec.email         = ["steve@stevegattuso.me"]

  spec.summary       = %q{A huginn agent for writing data to SQLite3 databases}
  spec.description   = %q{A huginn agent for writing data to SQLite3 databases}

  spec.homepage      = "https://github.com/stevenleeg/huginn_sqlite3_agent"

  spec.license       = "MIT"

  spec.files         = Dir['LICENSE.txt', 'lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = Dir['spec/**/*.rb']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "huginn_agent", '~> 0.2'
end
