require 'wda_client/version'
require 'wda_client/status'
require 'wda_client/sessions'

class WdaClient
  include ::WdaClient::Status
  include ::WdaClient::Sessions

  attr_accessor :session, :capability
  attr_reader :base_url

  BASE_URL = 'http://localhost:8100'

  def initialize(caps:, base_url: BASE_URL)
    valid_caps(caps)
    @capability = caps
    @base_url = base_url
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

  def valid_caps(caps)
    parsed_caps = JSON.parse(caps)
    raise ArgumentError, "should caps has desiredCapabilities" if parsed_caps["desiredCapabilities"].nil?
    raise ArgumentError, "should caps has bundleId" if parsed_caps["desiredCapabilities"]["bundleId"].nil?
    raise ArgumentError, "should caps has app" if parsed_caps["desiredCapabilities"]["app"].nil?
  end
end
