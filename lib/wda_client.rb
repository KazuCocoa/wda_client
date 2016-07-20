require 'wda_client/version'
require 'wda_client/status'
require 'wda_client/sessions'
require 'wda_client/screenshot'

class WdaClient
  include ::WdaClient::Status
  include ::WdaClient::Sessions
  include ::WdaClient::Screenshot

  attr_accessor :session_id, :capabilities, :desired_capabilities
  attr_reader :base_url

  BASE_URL = 'http://localhost:8100'

  def initialize(desired_capabilities:, base_url: BASE_URL)
    @desired_capabilities = parse(desired_capabilities)
    @base_url = base_url
    @capabilities = nil
    @session_id = nil
  end

  def generate_uri(url_path:)
    URI.parse(@base_url + url_path)
  end

  def generate_base_req(method:, url_path:)
    req = case method
          when 'get'
            Net::HTTP::Get.new(url_path)
          when 'post'
            Net::HTTP::Post.new(url_path)
          end
    req['Content-Type'] = 'application/json'

    req
  end

  private

  def parse(caps)
    parsed_caps = JSON.parse(caps)
    raise ArgumentError, "should caps has desiredCapabilities" if parsed_caps["desiredCapabilities"].nil?
    raise ArgumentError, "should caps has bundleId" if parsed_caps["desiredCapabilities"]["bundleId"].nil?

    parsed_caps
  end
end
