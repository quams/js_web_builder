# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'js_web_builder/version'

Gem::Specification.new do |spec|
  spec.name          = "js_web_builder"
  spec.version       = JSWebBuilder::VERSION
  spec.authors       = ["Jan Christian Albiez"]
  spec.email         = ["github@schuttmul.de"]

  spec.summary       = "Simplistic js asset building tool for web applications"
  spec.description   = "A very simple piece of ruby code which is supposed to be used with rake and allows to concatenate and reuse javascript files for any kind of web application"
  spec.homepage      = "https://github.com/quams/js_web_builder"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rake", "~> 12.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.1"
end
