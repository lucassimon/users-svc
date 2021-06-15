require_relative "lib/profiles/version"

Gem::Specification.new do |spec|
  spec.name        = "profiles"
  spec.version     = Profiles::VERSION
  spec.authors     = ["Write your name"]
  spec.email       = ["Write your email address"]
  spec.homepage    = 'http://mygemserver.com'
  spec.summary     = "Summary of Profiles."
  spec.description = "Description of Profiles."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = 'http://mygemserver.com'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = 'http://mygemserver.com'
  spec.metadata["changelog_uri"] = 'http://mygemserver.com'

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.3", ">= 6.1.3.2"
  spec.add_dependency "httparty"
end
