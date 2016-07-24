require 'json'

class WdaClient
  module Sessions
    def install
      uri = generate_uri(url_path: '/session')
      req = generate_base_req(method: 'post', url_path: '/session')
      req.body = @desired_capabilities.to_json

      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }

      result = JSON.parse(res.body)
      @session_id = result['sessionId'] || result['value']['sessionId']
      @capabilities = result['value']['capabilities']
      @status = result['status']

      result
    end

    def close
      return puts "no session" if @session_id.nil?

      uri = generate_uri(url_path: '/session')
      req = generate_base_req(method: 'delete', url_path: "/session/#{@session_id}")

      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }

      result = JSON.parse(res.body)
      @session_id = result['sessionId']
      @status = result['status']

      result
    end
  end
end
