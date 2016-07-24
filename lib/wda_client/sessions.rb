require 'json'

class WdaClient
  module Sessions
    def install
      req = generate_base_req(method: :post, url_path: '/session')
      req.body = @desired_capabilities.to_json

      res = Net::HTTP.start(@base_url.host, @base_url.port) { |http| http.request(req) }

      result = JSON.parse(res.body)
      @session_id = result['sessionId']
      @capabilities = result['value']['capabilities']
      @status = result['status']

      result
    end

    def close
      session_id = if @session_id.nil?
                     ""
                   else
                     @session_id
                   end
      req = generate_base_req(method: :delete, url_path: "/session/#{session_id}")

      res = Net::HTTP.start(@base_url.host, @base_url.port) { |http| http.request(req) }

      result = JSON.parse(res.body)
      @session_id = result['sessionId']
      @status = result['status']

      result
    end
  end
end
