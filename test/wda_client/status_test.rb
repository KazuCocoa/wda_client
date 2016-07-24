require "test_helper"
require 'webmock/minitest'
require 'json'

class WdaClient::StatusTest < Minitest::Test
  def test_get_status
    base_host = 'localhost:8100'

    json =<<-EXPECTED_JSON
{
  "value" : {
    "state" : "success",
    "os" : {
      "name" : "iPhone OS",
      "version" : "9.3"
    },
    "ios" : {
      "simulatorVersion" : "9.3"
    },
    "build" : {
      "time" : "Jul 18 2016 17:28:56"
    }
  },
  "sessionId" : null,
  "status" : 0
}
    EXPECTED_JSON

    caps =<<-CAPS
{
  "desiredCapabilities": {
    "bundleId": "com.kazucocoa",
    "app": "path/to/myApp.app"
  }
}
    CAPS

    stub_request(:get, "#{base_host}/status")
      .with(headers:{ 'Content-Type' => 'application/json' })
      .to_return(body: json)

    client = ::WdaClient.new desired_capabilities: caps
    res_json_body = client.get_status

    assert_equal JSON.parse(json), res_json_body
    assert_equal JSON.parse(caps), client.desired_capabilities
    assert_equal 0, client.status
  end
end
