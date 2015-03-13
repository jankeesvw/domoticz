require "spec_helper"

describe Domoticz::Switch do
  it "gets all available switches" do
    stub_server_with_fixture(params: "type=devices&filter=all&used=true", fixture: "switches.json")

    switches = Domoticz::Switch.all
    expect(switches.count).to eq 2

    expect(switches.first.name).to eq "Switch 1"
    expect(switches.first.dimmer).to be_truthy
    expect(switches.first.idx).to eq "1"
    expect(switches.first.type).to eq "Lighting 1"
    expect(switches.first.subtype).to eq "X10"
  end

  it "turns on a switch" do
    stub_server_with_fixture(params: "type=command&param=switchlight&idx=8&switchcmd=On", fixture: "switch_turn_on.json", required: true)

    switch = Domoticz::Switch.new
    switch.idx = "8"
    switch.on!
  end

  it "turns off a switch" do
    stub_server_with_fixture(params: "type=command&param=switchlight&idx=8&switchcmd=Off", fixture: "switch_turn_off.json", required: true)

    switch = Domoticz::Switch.new
    switch.idx = "8"
    switch.off!
  end

  it "toggles a switch" do
    stub_server_with_fixture(params: "type=command&param=switchlight&idx=8&switchcmd=Toggle", fixture: "switch_toggle.json", required: true)

    switch = Domoticz::Switch.new
    switch.idx = "8"
    switch.toggle!
  end
end
