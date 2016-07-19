require 'test_helper'

class WdaClientTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::WdaClient::VERSION
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

    client = ::WdaClient.new caps: caps
    uri = client.generate_uri(url_path: '/status')
    assert_equal 'http://localhost:8100/status', uri.to_s
  end
end
