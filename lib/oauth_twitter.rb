require "oauth_twitter/version"
require "oauth_twitter/config"
require "oauth_twitter/helper"
require "oauth_twitter/api/oauth"

module OauthTwitter
  HOST = "https://api.twitter.com"
  API_PATH = {
    request_token: '/oauth/request_token',
    access_token:  '/oauth/access_token',
    friends_ids:   '/1.1/friends/ids.json',
    users_lookup:  '/1.1/users/lookup.json',
    home_timeline: '/1.1/statuses/home_timeline.json'
  }
  include Helper
  def request_token(oauth_callback=nil)
    oauth = oauth_params(
      false, {oauth_callback: "http://local.dev:3000/twitter_login_successful"})
    response = send_request(:POST, API_PATH[:request_token], nil, oauth)
    p response.body, response.code, response.inspect
  end
end
