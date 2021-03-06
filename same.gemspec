# frozen_string_literal: true

require_relative "lib/same/version"

Gem::Specification.new do |spec|
  spec.name = "same"
  spec.version = Same::VERSION
  spec.authors = ["Andrius Chamentauskas"]
  spec.email = ["andrius.chamentauskas@gmail.com"]

  spec.summary = "SAME - EMS pattern evolved."
  spec.description = "SAME is a game framework loosely based on EMS pattern."
  spec.homepage = "https://github.com/andriusch/same"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/andriusch/same"
  spec.metadata["changelog_uri"] = "https://github.com/andriusch/same/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
