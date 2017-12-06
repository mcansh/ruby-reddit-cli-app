lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "reddit/version"

Gem::Specification.new do |spec|
  spec.name          = "reddit-ruby"
  spec.version       = Reddit::VERSION
  spec.authors       = ["Logan McAnsh"]
  spec.email         = ["logan@mcan.sh"]

  spec.summary       = "Get the current hot posts from r/ruby"
  spec.description   = "Get the current hot posts from r/ruby"
  spec.homepage      = "https://github.com/mcansh/ruby-reddit-cli-app"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables << 'reddit'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "colorize"
end
