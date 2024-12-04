Gem::Specification.new do |spec|
  spec.name          = "ruby-flow"
  spec.version       = "0.1.0"
  spec.authors       = ["Your Name"]
  spec.email         = ["your.email@example.com"]

  spec.summary       = "A Ruby library for creating interactive node-based UIs"
  spec.description   = "RubyFlow is a highly customizable library for building node-based editors, workflows and interactive diagrams, inspired by React Flow"
  spec.homepage      = "https://github.com/yourusername/ruby-flow"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir["lib/**/*", "LICENSE.txt", "README.md"]
  
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "sinatra", "~> 3.0"
  spec.add_development_dependency "sinatra-contrib", "~> 3.0"
  spec.add_development_dependency "puma", "~> 6.0"
end 