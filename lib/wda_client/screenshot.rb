require 'json'
require 'base64'

class WdaClient
  module Screenshot
    def take_screenshot(to_file: './snapshot.png')
      uri = generate_uri(url_path: '/screenshot')
      req = generate_base_req(method: 'get', url_path: '/screenshot')

      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }

      parsed_result = JSON.parse res.body

      File.write to_file, Base64.decode64(parsed_result['value'])

      parsed_result['output'] = to_file
      parsed_result
    end
  end
end
