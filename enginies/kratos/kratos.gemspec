require_relative "lib/kratos/version"

Gem::Specification.new do |spec|
  spec.name        = "kratos"
  spec.version     = Kratos::VERSION
  spec.authors     = [""]
  spec.email       = [""]
  spec.homepage    = "http://mygemserver.com"
  spec.summary     = "Summary of Kratos."
  spec.description = "Description of Kratos."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://mygemserver.com"
  spec.metadata["changelog_uri"] = "http://mygemserver.com"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.3", ">= 6.1.3.2"
end
