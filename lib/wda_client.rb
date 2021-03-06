require 'uri'
require 'net/http'

require_relative 'wda_client/version'
require_relative 'wda_client/status'
require_relative 'wda_client/sessions'
require_relative 'wda_client/screenshot'
require_relative 'wda_client/source'
require_relative 'wda_client/homescreen'

class WdaClient
  include ::WdaClient::Status
  include ::WdaClient::Sessions
  include ::WdaClient::Screenshot
  include ::WdaClient::Source
  include ::WdaClient::Homescreen

  attr_accessor :session_id, :capabilities, :desired_capabilities, :status
  attr_reader :base_url

  BASE_URL = 'http://localhost:8100'

  def initialize(desired_capabilities:, base_url: BASE_URL)
    @desired_capabilities = parse(desired_capabilities)
    @base_url = URI.parse(base_url)
    @capabilities = nil
    @session_id = nil
    @status = 0
  end

  def generate_base_req(method:, url_path:)
    req = case method
          when :get
            Net::HTTP::Get.new(url_path)
          when :post
            Net::HTTP::Post.new(url_path)
          when :delete
            Net::HTTP::Delete.new(url_path)
          else
            # no method
          end
    req['Content-Type'] = 'application/json'

    req
  end

  private

  def parse(caps)
    parsed_caps = JSON.parse(caps)
    raise ArgumentError, 'should caps has desiredCapabilities' if parsed_caps['desiredCapabilities'].nil?
    raise ArgumentError, 'should caps has bundleId' if parsed_caps['desiredCapabilities']['bundleId'].nil?

    parsed_caps
  end
end
