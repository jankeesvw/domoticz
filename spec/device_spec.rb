require "spec_helper"

describe Domoticz::Device do
  it "gets all available devices" do
    stub_server_with_fixture(params: "type=devices&filter=all&used=true", fixture: "switches.json")

    devices = Domoticz::Device.all
    expect(devices.count).to eq 2

    expect(devices.first.name).to eq "Switch 1"
    expect(devices.first.dimmer?).to be_truthy
    expect(devices.first.idx).to eq "1"
    expect(devices.first.type).to eq "Lighting 1"
    expect(devices.first.subtype).to eq "X10"
  end

  it "gets a specific device" do
    stub_server_with_fixture(params: "type=devices&filter=all&used=true", fixture: "switches.json")

    device = Domoticz::Device.find_by_id(1)
    expect(device).to be_a Domoticz::Device

    expect(device.name).to eq "Switch 1"
    expect(device.dimmer?).to be_truthy
    expect(device.idx).to eq "1"
    expect(device.type).to eq "Lighting 1"
    expect(device.subtype).to eq "X10"
  end

  it "turns on a switch" do
    stub_server_with_fixture(params: "type=command&param=switchlight&idx=8&switchcmd=On", fixture: "switch_turn_on.json", required: true)

    switch = Domoticz::Device.new
    switch.idx = "8"
    switch.on!
  end

  it "turns off a switch" do
    stub_server_with_fixture(params: "type=command&param=switchlight&idx=8&switchcmd=Off", fixture: "switch_turn_off.json", required: true)

    switch = Domoticz::Device.new
    switch.idx = "8"
    switch.off!
  end

  it "toggles a switch" do
    stub_server_with_fixture(params: "type=command&param=switchlight&idx=8&switchcmd=Toggle", fixture: "switch_toggle.json", required: true)

    switch = Domoticz::Device.new
    switch.idx = "8"
    switch.toggle!
  end

  it "gets the raw json data" do
    stub_server_with_fixture(params: "type=devices&filter=all&used=true", fixture: "temperature_device.json")

    switches = Domoticz::Device.all
    expect(switches.first.data).to eq ({
      "AddjMulti" => 1.0,
      "AddjMulti2" => 1.0,
      "AddjValue" => 0.0,
      "AddjValue2" => 0.0,
      "BatteryLevel" => 100,
      "CustomImage" => 0,
      "Data" => "20.6 C, 45 %",
      "Description" => "",
      "DewPoint" => "8.25",
      "Favorite" => 1,
      "HardwareID" => 3,
      "HardwareName" => "razberry",
      "HardwareType" => "OpenZWave USB",
      "HardwareTypeVal" => 21,
      "HaveTimeout" => false,
      "Humidity" => 45,
      "HumidityStatus" => "Comfortable",
      "ID" => "0601",
      "LastUpdate" => "2015-12-13 14:02:47",
      "Name" => "Woonkamer",
      "Notifications" => "false",
      "PlanID" => "5",
      "PlanIDs" => [5],
      "Protected" => false,
      "ShowNotifications" => true,
      "SignalLevel" => "-",
      "SubType" => "WTGR800",
      "Temp" => 20.6,
      "Timers" => "false",
      "Type" => "Temp + Humidity",
      "TypeImg" => "temperature",
      "Unit" => 0,
      "Used" => 1,
      "XOffset" => "185",
      "YOffset" => "592",
      "idx" => "47"
    })
  end
end
