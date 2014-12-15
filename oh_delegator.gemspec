$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'oh_delegator'
  gem.version       = '0.0.1'
  gem.authors       = ["BlackDuck Software"]
  gem.email         = ["info@blackducksoftware.com"]
  gem.summary       = %q{ActiveRecord model delegation}
  gem.description   = %q{Use delegators just like concerns}
  gem.homepage      = "https://bitbucket.org/notalex/oh_delegator"
  gem.license       = "MIT"

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.require_paths = ["lib"]
end
