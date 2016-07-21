require 'json'

class WdaClient
  module Source
    def get_source
      uri = generate_uri(url_path: "/source")
      req = generate_base_req(method: "get", url_path: "/source")

      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }

      JSON.parse res.body
    end
  end
end
