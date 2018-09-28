
require_relative 'lib/darknet/version'

Gem::Specification.new do |spec|
  spec.name          = "darknet-rb"
  spec.version       = Darknet::VERSION
  spec.authors       = ["Michael Adams"]
  spec.email         = ["michael@michaeladams.org"]

  spec.summary       = "A ruby wrapper for the darknet image analysis executable."
  spec.homepage      = "https://github.com/madleech/darknet"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.extensions = %w[ext/Rakefile]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
