require "oauth_twitter/version"
require "oauth_twitter/config"
require "oauth_twitter/helper"
require "oauth_twitter/api/application"
require "oauth_twitter/api/oauth"
require "oauth_twitter/api/statuses"
require "oauth_twitter/api/friends"
require "oauth_twitter/api/users"

module OauthTwitter
  include Helper
  include API::Application
  include API::Friends
  include API::Oauth
  include API::Statuses
  include API::Users
end
