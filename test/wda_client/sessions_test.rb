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
    assert_equal 0, client.status
  end

  def test_get_session_without_app
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
    "bundleId": "com.kazucocoa"
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
    assert_equal 0, client.status
  end

  def test_delete_session
    base_host = 'localhost:8100'

    json_install =<<-EXPECTED_JSON
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

    json_delete =<<-EXPECTED_JSON
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

    stub_request(:post, "#{base_host}/session")
      .with(headers:{ 'Content-Type' => 'application/json' })
      .to_return(body: json_install)

    stub_request(:delete, "#{base_host}/session/26FA8CEA-9D59-4EB1-8B19-84AFD7307936")
      .with(headers:{ 'Content-Type' => 'application/json' })
      .to_return(body: json_delete)

    client = ::WdaClient.new desired_capabilities: caps
    client.install
    assert_equal "26FA8CEA-9D59-4EB1-8B19-84AFD7307936", client.session_id

    res_json_body = client.close
    assert_equal JSON.parse(json_delete), res_json_body
    assert_equal nil, client.session_id
    assert_equal 0, client.status
  end

  def test_error_delete_session_because_alredy_closed
    base_host = 'localhost:8100'

    json_delete =<<-EXPECTED_JSON
{
  "value" : "Session does not exist",
  "sessionId" : null,
  "status" : 6
}
    EXPECTED_JSON

    caps =<<-CAPS
{
  "desiredCapabilities": {
    "bundleId": "com.kazucocoa"
  }
}
    CAPS

    stub_request(:delete, "#{base_host}/session/")
      .with(headers:{ 'Content-Type' => 'application/json' })
      .to_return(body: json_delete)

    client = ::WdaClient.new desired_capabilities: caps
    res_json_body = client.close
    assert_equal JSON.parse(json_delete), res_json_body
  end
end
