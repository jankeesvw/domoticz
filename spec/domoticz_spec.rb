require "spec_helper"

describe Domoticz do
  describe "configuration" do
    it "stores the user name" do
      Domoticz.configure do |config|
        config.server = "http://127.0.1.1:8080/"
        config.username = "username"
        config.password = "password"
      end
      expect(Domoticz.configuration.server).to eq "http://127.0.1.1:8080/"
      expect(Domoticz.configuration.username).to eq "username"
      expect(Domoticz.configuration.password).to eq "password"
    end

  end

  describe ".perform_api_request" do
    it "performs an api request and parses the resulting JSON" do
      expect(Net::HTTP).to receive(:start).and_return(double(body: %q{{"result": "ok"}}))

      expect(Domoticz.perform_api_request("param")).to eq({ "result" => "ok" })
    end

    describe "basic auth" do
      it "uses basic auth to authenticate" do
        Domoticz.configure do |config|
          config.server = "http://127.0.1.1:8080/"
          config.username = "username"
          config.password = "password"
        end

        expect(Net::HTTP).to receive(:start).and_return(double(body: %q{{"result": "ok"}}))
        expect_any_instance_of(Net::HTTP::Get).to receive(:basic_auth).with("username", "password")

        Domoticz.perform_api_request("param")
      end
    end

    it "skips basic auth if no username and password are present" do
      Domoticz.configure do |config|
        config.server = "http://127.0.1.1:8080/"
      end

      expect(Net::HTTP).to receive(:start).and_return(double(body: %q{{"result": "ok"}}))
      expect_any_instance_of(Net::HTTP::Get).not_to receive(:basic_auth)

      Domoticz.perform_api_request("param")
    end
  end
end
