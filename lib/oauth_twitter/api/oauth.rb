module OauthTwitter
  module API
    module Oauth
      PATH = {
        request_token: '/oauth/request_token',
         access_token: '/oauth/access_token'
      }

      def request_token(oauth_callback=nil)
        callback_url = oauth_callback || Config.oauth_callback
        oauth = oauth_params(
          false,
          {oauth_callback: callback_url})
        return send_request(:POST, PATH[:request_token], nil, oauth)
      end

      def access_token(oauth_verifier)
        oauth = oauth_params(true)
        return send_request(:POST, PATH[:access_token], {oauth_verifier: oauth_verifier}, oauth)
      end

    end
  end
end
