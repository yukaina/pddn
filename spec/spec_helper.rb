$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pddn'

if ENV['CI']
  require 'codeclimate-test-reporter'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[CodeClimate::TestReporter::Formatter]
  SimpleCov.start 'test_frameworks'
  CodeClimate::TestReporter.start
end
