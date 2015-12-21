require "domoticz/version"
require "domoticz/configuration"
require "domoticz/device"
require "json"

module Domoticz
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.perform_api_request(params)
    username = Domoticz.configuration.username
    password = Domoticz.configuration.password

    uri = URI(Domoticz.configuration.server + "json.htm?" + params)
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(username, password) if username && password
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") { |http| http.request(request) }

    JSON.parse(response.body)
  end
end
