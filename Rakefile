require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "itau_to_ofx"
  gem.homepage = "http://github.com/fgrehm/itau_to_ofx"
  gem.license = "MIT"
  gem.summary = %Q{Converte um extrato do Itau para OFX}
  gem.description = %Q{Converte um extrato do Itau para OFX}
  gem.email = "fgrehm@gmail.com"
  gem.files = Dir.glob('lib/**/*.rb')
  gem.authors = ["Fabio Rehm"]
  
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  gem.add_runtime_dependency 'activesupport', '~> 2.3.8'
  gem.add_runtime_dependency 'ffi', '~> 0.6.3'
  gem.add_runtime_dependency 'clipboard', '~> 0.9.2'
  
  gem.add_development_dependency "shoulda", ">= 0"
  gem.add_development_dependency "bundler", "~> 1.0.0"
  gem.add_development_dependency "jeweler", "~> 1.5.1"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test
