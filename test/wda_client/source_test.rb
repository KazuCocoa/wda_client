require "test_helper"
require 'webmock/minitest'
require 'json'

class WdaClient::SourceTest < Minitest::Test
  def test_get_source
    base_host = 'localhost:8100'

    json =<<-EXPECTED_JSON
{
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

    stub_request(:get, "#{base_host}/source")
      .with(headers:{ 'Content-Type' => 'application/json' })
      .to_return(body: json)

    client = ::WdaClient.new desired_capabilities: caps
    res_json_body = client.get_source

    assert_equal JSON.parse(json), res_json_body
  end
end
