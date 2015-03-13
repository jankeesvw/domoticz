require "domoticz"
require "support/spec_helpers"

RSpec.configure do |config|
  config.before(:each) do
    Domoticz.reset
  end
end
