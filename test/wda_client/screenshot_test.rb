require "test_helper"
require 'webmock/minitest'
require 'json'

class WdaClient::ScreenshotTest < Minitest::Test
  def test_take_screenshot
    base_host = 'localhost:8100'
    test_file = "./test/data/sample_screen.png"

    json =<<-EXPECTED_JSON
{
  "value": "",
  "sessionId": "nil",
  "status": 0
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

    expected_result = JSON.parse(json)
    expected_result["output"] = "./test/data/sample_screen.png"

    client = ::WdaClient.new desired_capabilities: caps
    res_json_body = client.take_screenshot(to_file: test_file)

    assert_equal expected_result, res_json_body
    assert File.exist? test_file

    File.delete test_file
  end
end
