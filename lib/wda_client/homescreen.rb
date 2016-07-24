require 'json'

class WdaClient
  module Homescreen
    def homescreen
      req = generate_base_req(method: :post, url_path: '/homescreen')
      req.body = ""

      res = Net::HTTP.start(@base_url.host, @base_url.port) { |http| http.request(req) }

      JSON.parse(res.body)
    end
  end
end
