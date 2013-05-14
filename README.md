# OauthTwitter

An OAuth library to interact with Twitter API v1.1, by simply calling methods on instances. The methods name is designed to be similar to Twitter's API. For example:

If you want to load home timeline for certain user, just do:

	response = your_instance.home_timeline
	response.each {|r| process_response(r)}

The response is a nested hash that structured the same as Twitter's response JSON.

## 1. Installation

Add this line to your application's Gemfile:

    gem 'oauth_twitter'

Then execute:

    $ bundle install

Or install it yourself use:

    $ gem install oauth_twitter
    
## 2. Setup and Usage

1) Configure __OauthTwitter__ on app initialization:

	OauthTwitter::Config.setup do |c|
	  c.consumer_key = "#{your_twitter_consumer_key}"
	  c.consumer_secret = "#{twitter_consumer_secret}"
	  
	  # Your don't have to include following in your initializer,
	  # but OauthTwitter will fallback to this url 
	  # if you don't provide them in certain functions' args
	  
	  c.oauth_callback = "#{oauth_request_token_callback_address}"
	end

2) Include `OauthTwitter` in your class like:
	
	class YouClass
	  include OauthTwitter
	  …
	end

3) Implement `attr_accessor` in your class, so __OauthTwitter__ could load tokens from `YourClass`:
	
	class YourClass
	  include OauthTwitter
	  
	  attr_accessor :oauth_token, :oauth_token_secret
	  ...
	end

4) You can start calling methods on `YourClass`:

	you_instance = YourClass.new
	you_instance.request_token("callback_url")

## Documentation

Still a work in process...