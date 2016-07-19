require 'json'

class WdaClient
  module Sessions
    def install
      uri = generate_uri(url_path: "/session")
      req = generate_base_req(method: "post", url_path: "/session")
      req.body = @capability

      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(req)
      end

      JSON.parse res.body
    end
  end
end
