require_relative 'lib/teamtailor/version'

Gem::Specification.new do |spec|
  spec.name          = "teamtailor"
  spec.version       = Teamtailor::VERSION
  spec.authors       = ["André Ligné"]
  spec.email         = ["hi@andreligne.se"]

  spec.summary       = %q{Library for interacting with the Teamtailor API}
  spec.homepage      = "https://github.com/bzf/teamtailor-gem"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bzf/teamtailor-gem"
  spec.metadata["changelog_uri"] = "https://github.com/bzf/teamtailor-gem/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
