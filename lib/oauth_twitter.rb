require "oauth_twitter/version"
require "oauth_twitter/config"
require "oauth_twitter/helper"
require "oauth_twitter/api/oauth"
require "oauth_twitter/api/statuses"
require "oauth_twitter/api/friends"
require "oauth_twitter/api/users"

module OauthTwitter
  include Helper
  include API::Oauth
  include API::Statuses
  include API::Friends
  include API::Users
end
