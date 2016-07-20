require 'json'

class WdaClient
  module Status
    def get_status
      uri = generate_uri(url_path: "/status")
      req = generate_base_req(method: "get", url_path: "/status")

      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }

      JSON.parse res.body
    end
  end
end
