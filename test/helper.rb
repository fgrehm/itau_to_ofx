require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'itau_to_ofx'

class Test::Unit::TestCase
  def full_fixture_path(filename)
    File.dirname(__FILE__) + "/fixtures/" + filename
  end
  
  def parse_line(line)
    @transaction = @scraper.parse_line(line)
  end
end

class Time

  class << self

    ##
    # Time.warp
    #   Allows you to stub-out Time.now to return a pre-determined time for calls to Time.now.
    #   Accepts a Fixnum to be added to the current Time.now, or an instance of Time
    #
    #   item.expires_at = Time.now + 10
    #   assert(false, item.expired?)
    #
    #   Time.warp(10) do
    #     assert(true, item.expired?)
    #   end
    ##
    def warp(time)
      @warp = time.is_a?(Fixnum) ? (Time.now + time) : time
      yield
      @warp = nil
    end

    alias original_now now

    def now
      @warp || original_now
    end

  end

end

class Date
  class << self
    def warp(days)
      @warp = days.is_a?(Fixnum) ? (Date.today + days) : days
      yield
      @warp = nil
    end

    alias original_today today

    def today
      @warp || original_today
    end
  end
end
