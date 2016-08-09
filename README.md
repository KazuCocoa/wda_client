# WdaClient

WdaClient is my minimal client for WebDriverAgent to help some operations.

[![Build Status](https://travis-ci.org/KazuCocoa/wda_client.svg?branch=master)](https://travis-ci.org/KazuCocoa/wda_client)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wda_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wda_client

### Requirement
- Should use WebDriverAgent over the below commit hash because `/source` supported from it.
    - https://github.com/facebook/WebDriverAgent/commit/9648eb1747ef7c64630d78256f82e675742f8431

## Usage

1. Launch WebDriverAgent
    - Read [official document](https://github.com/facebook/WebDriverAgent)
2. load this module and create instance
```
$ pry
> require 'wda_client'
> client = WdaClient.new desired_capabilities: "{\"desiredCapabilities\":{\"bundleId\": \"com.my.app\"}}"
> client.get_status      # https://github.com/facebook/WebDriverAgent/wiki/Queries#checking-service-status
> client.take_screenshot # https://github.com/facebook/WebDriverAgent/wiki/Queries#get-a-screenshot
> client.get_source      # https://github.com/facebook/WebDriverAgent/wiki/Queries#source-aka-tree
> client.close           # close session
```

## Advanced
1. Launch WebDriverAgent with particular port number
    1. launch with `fbsimctl` with particular port number
        - https://github.com/facebook/WebDriverAgent/wiki/Starting-WebDriverAgent
    2. change source code directly
        - [code](https://github.com/facebook/WebDriverAgent/blob/4addbcd4a3d9e5ec6241ac4ad3830227f2f4ccd4/WebDriverAgentLib/Utilities/FBConfiguration.m#L16)
    3. provide port number via environment of `USE_PORT`
        - [code](https://github.com/facebook/WebDriverAgent/blob/4addbcd4a3d9e5ec6241ac4ad3830227f2f4ccd4/WebDriverAgentLib/Utilities/FBConfiguration.m#L36)
2. Generate instance of `WdaClient` with `base_url`.
- Set port `4100`, for insrance.

```ruby
client = WdaClient.new desired_capabilities: "{\"desiredCapabilities\":{\"bundleId\": \"com.my.app\"}}", base_url: 'http://localhost:4100'
```

## Current Status

- Get Status
- Get source
- go to homescreen
- Take Screenshot
- install app and get session id
- get current session id
- close current session

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/KazuCocoa/wda_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
