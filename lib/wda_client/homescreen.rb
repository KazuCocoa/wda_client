require 'json'

class WdaClient
  module Homescreen
    def homescreen
      uri = generate_uri(url_path: '/homescreen')
      req = generate_base_req(method: 'post', url_path: '/homescreen')
      req.body = ""

      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }

      JSON.parse(res.body)
    end
  end
end
