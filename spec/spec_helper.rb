require 'rspec'
require 'ronway'

Dir[File.join(File.dirname(__FILE__), "../lib/ronway.rb")]
  .each { |f| require f }
