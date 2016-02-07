require 'codeclimate-test-reporter'
SimpleCov.start do
  add_filter '/spec/html/'
  formatter SimpleCov::Formatter::MultiFormatter[
              SimpleCov::Formatter::HTMLFormatter,
              CodeClimate::TestReporter::Formatter
            ]
end
