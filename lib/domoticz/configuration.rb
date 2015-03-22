module Domoticz
  class Configuration
    attr_accessor :server
    attr_accessor :username
    attr_accessor :password

    def initialize
      self.server = "http://127.0.0.1:8080/"
    end
  end
end
