gem "bundler", "< 1.16"

gem "bundler", "< 1.16"

begin
  require "bundler/inline"
rescue LoadError => e
  $stderr.puts "Bundler version 1.10 or later is required. Please update your Bundler"
  raise e
end

gemfile(true) do
  source "https://rubygems.org"
  gem "rails", github: "rails/rails", branch: "5-1-stable"
end

require "active_support"
require "active_support/core_ext/object/blank"
require "minitest/autorun"

class BugTest < Minitest::Test
  def test_stuff
    assert "zomg".present?
    refute "".present?
  end
end
