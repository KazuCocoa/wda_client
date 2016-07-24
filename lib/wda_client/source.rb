require 'json'

class WdaClient
  module Source
    def get_source
      req = generate_base_req(method: :get, url_path: '/source')

      res = Net::HTTP.start(@base_url.host, @base_url.port) { |http| http.request(req) }

      JSON.parse res.body
    end
  end
end
