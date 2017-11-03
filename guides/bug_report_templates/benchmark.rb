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
  gem "benchmark-ips"
end

require "active_support"
require "active_support/core_ext/object/blank"

# Your patch goes here.
class String
  def fast_blank?
    true
  end
end

# Enumerate some representative scenarios here.
#
# It is very easy to make an optimization that improves performance for a
# specific scenario you care about but regresses on other common cases.
# Therefore, you should test your change against a list of representative
# scenarios. Ideally, they should be based on real-world scenarios extracted
# from production applications.
SCENARIOS = {
  "Empty"            => "",
  "Single Space"     => " ",
  "Two Spaces"       => "  ",
  "Mixed Whitspaces" => " \t\r\n",
  "Very Long String" => " " * 100
}

SCENARIOS.each_pair do |name, value|
  puts
  puts " #{name} ".center(80, "=")
  puts

  Benchmark.ips do |x|
    x.report("blank?")      { value.blank? }
    x.report("fast_blank?") { value.fast_blank? }
    x.compare!
  end
end
