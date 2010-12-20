# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{itau_to_ofx}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Fabio Rehm"]
  s.date = %q{2010-12-19}
  s.default_executable = %q{itau_to_ofx}
  s.description = %q{Converte um extrato do Itau para OFX}
  s.email = %q{fgrehm@gmail.com}
  s.executables = ["itau_to_ofx"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    "lib/itau_to_ofx.rb",
    "lib/itau_to_ofx/cli.rb",
    "lib/itau_to_ofx/generator.rb",
    "lib/itau_to_ofx/scraper.rb",
    "lib/itau_to_ofx/scraper/base.rb",
    "lib/itau_to_ofx/scraper/credit_card.rb",
    "lib/itau_to_ofx/scraper/savings.rb",
    "lib/itau_to_ofx/transaction.rb"
  ]
  s.homepage = %q{http://github.com/fgrehm/itau_to_ofx}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Converte um extrato do Itau para OFX}
  s.test_files = [
    "test/helper.rb",
    "test/scraper/test_credit_card.rb",
    "test/scraper/test_savings.rb",
    "test/test_generator.rb",
    "test/test_transaction.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["~> 2.3.8"])
      s.add_runtime_dependency(%q<ffi>, ["~> 0.6.3"])
      s.add_runtime_dependency(%q<clipboard>, ["~> 0.9.2"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 2.3.8"])
      s.add_runtime_dependency(%q<ffi>, ["~> 0.6.3"])
      s.add_runtime_dependency(%q<clipboard>, ["~> 0.9.2"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.1"])
    else
      s.add_dependency(%q<activesupport>, ["~> 2.3.8"])
      s.add_dependency(%q<ffi>, ["~> 0.6.3"])
      s.add_dependency(%q<clipboard>, ["~> 0.9.2"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<activesupport>, ["~> 2.3.8"])
      s.add_dependency(%q<ffi>, ["~> 0.6.3"])
      s.add_dependency(%q<clipboard>, ["~> 0.9.2"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 2.3.8"])
    s.add_dependency(%q<ffi>, ["~> 0.6.3"])
    s.add_dependency(%q<clipboard>, ["~> 0.9.2"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<activesupport>, ["~> 2.3.8"])
    s.add_dependency(%q<ffi>, ["~> 0.6.3"])
    s.add_dependency(%q<clipboard>, ["~> 0.9.2"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
  end
end

