require "spec_helper"

describe Domoticz do
  it "returns hellow world" do
    expect(Domoticz.hello).to eq "Hello Domoticz"
  end
end