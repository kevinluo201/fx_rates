
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fx_rates/version"

Gem::Specification.new do |spec|
  spec.name          = "fx_rates"
  spec.version       = FXRates::VERSION
  spec.authors       = ["Kevin Luo"]
  spec.email         = ["kevin.luo@hey.com"]

  spec.summary       = %q{It is a wrapper gem for FXRatesAPI}
  spec.description   = %q{You can use this gem to call all APIs provided by FXRatesAPI with ease.}
  spec.homepage      = "https://github.com/kevinluo201/fx_rates"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/kevinluo201/fx_rates"
    spec.metadata["changelog_uri"] = "https://github.com/kevinluo201/fx_rates"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "zeitwerk", "~> 2.0"
end
