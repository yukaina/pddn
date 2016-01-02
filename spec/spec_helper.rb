$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pddn'
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
]
SimpleCov.start 'rails'
