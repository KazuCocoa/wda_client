require "test_helper"
require 'webmock/minitest'
require 'json'

class WdaClient::SessionsTest < Minitest::Test
  def test_get_session
    base_host = 'localhost:8100'

    json =<<-EXPECTED_JSON
{
  "value" : {
    "sessionId" : "26FA8CEA-9D59-4EB1-8B19-84AFD7307936",
    "capabilities" : {
      "device" : "iphone",
      "browserName" : "My App",
      "sdkVersion" : "9.3",
      "CFBundleIdentifier" : "com.kazucocoa"
    }
  },
  "sessionId" : "26FA8CEA-9D59-4EB1-8B19-84AFD7307936",
  "status" : 0
}
    EXPECTED_JSON

    expected_caps =<<-EXPECTED_CAPS
{
  "device" : "iphone",
  "browserName" : "My App",
  "sdkVersion" : "9.3",
  "CFBundleIdentifier" : "com.kazucocoa"
}
    EXPECTED_CAPS

    caps =<<-CAPS
{
  "desiredCapabilities": {
    "bundleId": "com.kazucocoa",
    "app": "path/to/myApp.app"
  }
}
    CAPS

    stub_request(:post, "#{base_host}/session")
      .with(headers:{ 'Content-Type' => 'application/json' })
      .to_return(body: json)

    client = ::WdaClient.new desired_capabilities: caps
    res_json_body = client.install

    assert_equal JSON.parse(json), res_json_body
    assert_equal "26FA8CEA-9D59-4EB1-8B19-84AFD7307936", client.session_id
    assert_equal JSON.parse(expected_caps), client.capabilities
    assert_equal JSON.parse(caps), client.desired_capabilities
  end
end
