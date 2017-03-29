# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_login/version'

Gem::Specification.new do |spec|
  spec.name          = "easy_login"
  spec.version       = EasyLogin::VERSION
  spec.authors       = ["goshan"]
  spec.email         = ["goshan.hanqiu@dena.jp"]

  spec.summary       = %q{a simple user session controling tool for rails}
  spec.description   = %q{a simple session controller which just including :sign_in, :sign_out, :sign_in?, :current_user, :current_user? for controllers and :current_user, :current_user?, :sign_in? for views}
  spec.homepage      = "https://github.com/goshan/easy_login"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "json", "< 2.0, >= 1.8"
end
