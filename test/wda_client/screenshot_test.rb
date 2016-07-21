require "test_helper"
require 'webmock/minitest'
require 'json'

class WdaClient::ScreenshotTest < Minitest::Test
  def test_take_screenshot
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

    stub_request(:get, "#{base_host}/screenshot")
      .with(headers:{ 'Content-Type' => 'application/json' })
      .to_return(body: json)

    client = ::WdaClient.new desired_capabilities: caps
    res_json_body = client.take_screenshot

    assert_equal JSON.parse(json), res_json_body
  end
end
