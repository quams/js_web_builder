$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'js_web_builder'

require 'minitest/autorun'
require 'minitest/reporters'

# reporter
reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]
