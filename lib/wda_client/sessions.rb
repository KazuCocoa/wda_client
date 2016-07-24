require 'json'

class WdaClient
  module Sessions
    def install
      req = generate_base_req(method: 'post', url_path: '/session')
      req.body = @desired_capabilities.to_json

      res = Net::HTTP.start(@base_url.host, @base_url.port) { |http| http.request(req) }

      result = JSON.parse(res.body)
      @session_id = result['sessionId'] || result['value']['sessionId']
      @capabilities = result['value']['capabilities']
      @status = result['status']

      result
    end

    def close
      return puts "no session" if @session_id.nil?

      req = generate_base_req(method: 'delete', url_path: "/session/#{@session_id}")

      res = Net::HTTP.start(@base_url.host, @base_url.port) { |http| http.request(req) }

      result = JSON.parse(res.body)
      @session_id = result['sessionId']
      @status = result['status']

      result
    end
  end
end
