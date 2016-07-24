require "test_helper"
require 'webmock/minitest'
require 'json'

class WdaClient::SourceTest < Minitest::Test
  def test_get_source
    base_host = 'localhost:8100'

    json =<<-EXPECTED_JSON
{
  "value":
  {
    "tree":
    {
      "isEnabled":"1","isVisible":"1","frame":"{{0, 0}, {320, 568}}","children":
      [
        {
          "isEnabled":"1","isVisible":"0","frame":"{{0, 0}, {320, 568}}","children":
          [
            {
              "isEnabled":"1","isVisible":"0","frame":"{{0, 0}, {320, 568}}","children":
              [
                {
                  "isEnabled":"1","isVisible":"0","frame":"{{0, 0}, {320, 568}}","children":
                  [
                    {"isEnabled":"1","isVisible":"0","frame":"{{0, 0}, {320, 568}}","rect":{"origin":{"x":0,"y":0},"size":{"width":320,"height":568}},"value":null,"label":null,"type":"Image","name":null,"rawIdentifier":null}
                  ],
                  "rect":{"origin":{"x":0,"y":0},"size":{"width":320,"height":568}},
                  "value":null,
                  "label":null,
                  "type":"Other",
                  "name":null,"rawIdentifier":null
                }
              ]
            }
          ]
        }
      ]
    }
  },
  "sessionId": null,
  "status":0
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

    expected_json = JSON.parse(json)
    assert_equal expected_json, res_json_body
  end
end
