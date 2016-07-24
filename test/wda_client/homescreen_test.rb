require "test_helper"
require 'webmock/minitest'
require 'json'

class WdaClient::HomescreenTest < Minitest::Test
  def test_get_homescreen
    base_host = 'localhost:8100'

    json =<<-EXPECTED_JSON
{
  "value" : {

  },
  "sessionId" : null,
  "status" : 0
}
    EXPECTED_JSON

    caps =<<-CAPS
{
  "desiredCapabilities": {
    "bundleId": "com.kazucocoa"
  }
}
    CAPS

    stub_request(:post, "#{base_host}/homescreen")
      .with(headers:{ 'Content-Type' => 'application/json' })
      .to_return(body: json)

    client = ::WdaClient.new desired_capabilities: caps
    res_json_body = client.homescreen

    assert_equal JSON.parse(json), res_json_body
  end
end
