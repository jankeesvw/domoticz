module Domoticz
  class Device
    attr_accessor :idx
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

    def temperature
      temp
    end

    def dimmer?
      isDimmer
    end

    def method_missing(method_sym, *arguments, &block)
      hash = Hash[@data.map { |k, v| [k.downcase, v] }]
      key = method_sym.to_s.downcase

      if hash.has_key?(key)
        hash[key]
      else
        super
      end
    end

    def self.find_by_id(id)
      all.find { |d| d.idx == id.to_s }
    end

    def self.all
      Domoticz.perform_api_request("type=devices&filter=all&used=true")["result"].map do |json|
        Device.new_from_json(json)
      end
    end

    def self.new_from_json(json)
      device = self.new
      device.data = json
      device.idx = json["idx"]
      device
    end
  end
end
