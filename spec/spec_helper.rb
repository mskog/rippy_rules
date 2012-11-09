require 'rspec'
require 'rippy_rules'
require 'webmock/rspec'
require 'vcr'
require "yaml"

SPEC_DIR = File.dirname(__FILE__)
lib_path = File.expand_path("#{SPEC_DIR}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)


if File.exists?("spec/config.yml") == false
  puts "Error. Please make sure that 'spec/config.yml' exists with the correct values before running the specs. See example file"
  exit
end

config = YAML::load_file("spec/config.yml")
WHATCD_USERNAME = config['whatcd_username']
WHATCD_PASSWORD = config['whatcd_password']


RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
  config.mock_framework = :mocha
  config.extend VCR::RSpec::Macros
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassette_library'
  c.hook_into  :webmock
  c.default_cassette_options = { :record => :none}

  c.filter_sensitive_data('<WHATCD_USERNAME>') { WHATCD_USERNAME}
  c.filter_sensitive_data('<WHATCD_PASSWORD>') { WHATCD_PASSWORD}
end