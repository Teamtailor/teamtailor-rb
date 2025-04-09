# frozen_string_literal: true

require_relative "lib/teamtailor/version"

Gem::Specification.new do |spec|
  spec.name          = "teamtailor"
  spec.version       = Teamtailor::VERSION
  spec.authors       = ["André Ligné", "Jonas Brusman"]
  spec.email         = ["andre@teamtailor.com", "jonas@teamtailor.com"]

  spec.summary       = "Library for interacting with the Teamtailor API"
  spec.homepage      = "https://github.com/Teamtailor/teamtailor-rb"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Teamtailor/teamtailor-rb"
  spec.metadata["changelog_uri"] = "https://github.com/Teamtailor/teamtailor-rb/main/CHANGELOG.md"

  spec.extra_rdoc_files = ["README.md"]

  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_dependency "typhoeus", "~> 1.4.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
