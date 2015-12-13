module Domoticz
  class Device
    attr_accessor :idx
    attr_accessor :dimmer
    attr_accessor :name
    attr_accessor :subtype
    attr_accessor :type
    attr_accessor :data

    def on!
      Domoticz.perform_api_request("type=command&param=switchlight&idx=#{idx}&switchcmd=On")
    end

    def off!
      Domoticz.perform_api_request("type=command&param=switchlight&idx=#{idx}&switchcmd=Off")
    end

    def toggle!
      Domoticz.perform_api_request("type=command&param=switchlight&idx=#{idx}&switchcmd=Toggle")
    end

    def self.all
      Domoticz.perform_api_request("type=devices&filter=all&used=true")["result"].map do |json|
        Device.new_from_json(json)
      end
    end

    def self.new_from_json(json)
      device = self.new
      device.data = json
      device.name = json["Name"]
      device.dimmer = json["IsDimmer"]
      device.idx = json["idx"]
      device.type = json["Type"]
      device.subtype = json["SubType"]
      device
    end
  end
end
