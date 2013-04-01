module OauthTwitter
  module API
    module Oauth
      PATH = {
        request_token: '/oauth/request_token',
         access_token: '/oauth/access_token'
      }
      
      def request_token(oauth_callback=nil)
        oauth = oauth_params(
          false, {oauth_callback: "http://local.dev:3000/twitter_login_successful"})
        return send_request(:POST, PATH[:request_token], nil, oauth)
      end
      
    end
  end
end
