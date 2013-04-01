require "oauth_twitter/version"
require "oauth_twitter/config"
require "oauth_twitter/helper"
require "oauth_twitter/api/oauth"

module OauthTwitter
  include Helper
  include API::Oauth
  API_PATH = {
    friends_ids:   '/1.1/friends/ids.json',
    users_lookup:  '/1.1/users/lookup.json',
    home_timeline: '/1.1/statuses/home_timeline.json'
  }
  
end
