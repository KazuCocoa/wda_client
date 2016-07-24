require 'json'

class WdaClient
  module Status
    def get_status
      req = generate_base_req(method: :get, url_path: '/status')

      res = Net::HTTP.start(@base_url.host, @base_url.port) { |http| http.request(req) }

      result = JSON.parse res.body
      @status = result['status']

      result
    end
  end
end
