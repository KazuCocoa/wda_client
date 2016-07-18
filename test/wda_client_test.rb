require 'test_helper'
require 'webmock/minitest'
require 'json'

class WdaClientTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::WdaClient::VERSION
  end

  def test_generate_url
    client = ::WdaClient.new caps: 'dummy caps'
    uri = client.generate_uri(url_path: '/status')
    assert_equal 'http://localhost:8100/status', uri.to_s
  end

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

    stub_request(:get, "#{base_host}/status")
      .with(headers:{ 'Content-Type' => 'application/json' })
      .to_return(body: json)

    client = ::WdaClient.new caps: "dummy caps"
    res_json_body = client.get_status

    assert_equal JSON.parse(json), res_json_body
  end
end
