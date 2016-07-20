require 'json'

class WdaClient
  module Screenshot
    def take_screenshot
      uri = generate_uri(url_path: "/screenshot")
      req = generate_base_req(method: "get", url_path: "/screenshot")

      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }

      JSON.parse res.body
    end
  end
end
