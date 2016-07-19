require 'json'

class WdaClient
  module Sessions
    def install
      uri = generate_uri(url_path: "/session")
      req = generate_base_req(method: "post", url_path: "/session")
      req.body = @desired_capabilities

      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(req)
      end

      result = JSON.parse(res.body)
      @session_id = result["sessionId"] || result["value"]["sessionId"]
      @capabilities = result["value"]["capabilities"]

      result
    end
  end
end
