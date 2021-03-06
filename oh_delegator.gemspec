$:.push File.expand_path('../lib', __FILE__)
require 'oh_delegator/version'

Gem::Specification.new do |gem|
  gem.name          = 'oh_delegator'
  gem.version       = OhDelegator::Version::STRING
  gem.authors       = ["BlackDuck Software"]
  gem.email         = ["info@blackducksoftware.com"]
  gem.summary       = %q{ActiveRecord model delegation}
  gem.description   = %q{Use delegators just like concerns}
  gem.homepage      = "https://github.com/blackducksw/oh_delegator"
  gem.license       = "MIT"

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.require_paths = ["lib"]
end
