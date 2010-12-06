require 'rubygems'

gem 'activesupport', '~> 2.3.8'

# TODO Require only the stuff we need
require 'active_support/all'


$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module ItauToOfx
end

require 'itau_to_ofx/transaction'
require 'itau_to_ofx/scraper'
require 'itau_to_ofx/generator'
