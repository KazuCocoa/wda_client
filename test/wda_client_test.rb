require 'test_helper'

class WdaClientTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::WdaClient::VERSION
  end

  def test_failed_with_blank_caps
    caps =<<-CAPS
{
}
    CAPS
    assert_raises(ArgumentError, "should caps has desiredCapabilities") { ::WdaClient.new(desired_capabilities: caps) }
  end

  def test_failed_caps_without_bundleId
    caps =<<-CAPS
{
  "desiredCapabilities": {
  }
}
    CAPS
    assert_raises(ArgumentError, "should caps has bundleId") { ::WdaClient.new(desired_capabilities: caps) }
  end

  def test_failed_caps_without_app
    caps =<<-CAPS
{
  "desiredCapabilities": {
    "bundleId": "com.kazucocoa"
  }
}
    CAPS
    assert_raises(ArgumentError, "should caps has app") { ::WdaClient.new(desired_capabilities: caps) }
  end

  def test_generate_url
    caps =<<-CAPS
{
  "desiredCapabilities": {
    "bundleId": "com.kazucocoa",
    "app": "path/to/myApp.app"
  }
}
    CAPS

    client = ::WdaClient.new desired_capabilities: caps
    uri = client.generate_uri(url_path: '/status')
    assert_equal 'http://localhost:8100/status', uri.to_s
    assert_equal JSON.parse(caps), client.desired_capabilities
    assert_equal nil, client.session_id
    assert_equal nil, client.capabilities
  end
end
