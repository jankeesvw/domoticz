module Domoticz
  class Switch
    attr_accessor :idx
    attr_accessor :dimmer
    attr_accessor :name
    attr_accessor :subtype
    attr_accessor :type

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
        Switch.new_from_json(json)
      end
    end

    def self.new_from_json(json)
      switch = self.new
      switch.name = json["Name"]
      switch.dimmer = json["IsDimmer"]
      switch.idx = json["idx"]
      switch.type = json["Type"]
      switch.subtype = json["SubType"]
      switch
    end
  end
end
