def stub_server_with_fixture(params:, fixture:, required: false)
  json = JSON.parse(File.read("spec/fixtures/" + fixture))
  if required
    expect(Domoticz).to receive(:perform_api_request).with(params).and_return(json)
  else
    allow(Domoticz).to receive(:perform_api_request).with(params).and_return(json)
  end
end
