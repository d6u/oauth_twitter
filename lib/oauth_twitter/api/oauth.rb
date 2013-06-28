module OauthTwitter
  module API
    module Oauth
      PATH = {
        :oauth_authenticate => '/oauth/authenticate',
        :oauth_authorize => '/oauth/authorize',
        :oauth_access_token => '/oauth/access_token',
        :oauth_request_token => '/oauth/request_token'
      }

      def oauth_authenticate(params={}, options={})
        return send_request(:GET, PATH[:oauth_authenticate], params, true, options)
      end

      def oauth_authorize(params={}, options={})
        return send_request(:GET, PATH[:oauth_authorize], params, true, options)
      end

      def oauth_access_token(params={}, options={})
        return send_request(:POST, PATH[:oauth_access_token], params, true, options)
      end

      def oauth_request_token(params={}, options={})
        callback_url = params[:oauth_callback] || Config.oauth_callback
        return send_request(:POST, PATH[:oauth_request_token], nil, [false, {:oauth_callback => callback_url}], options)
      end

    end
  end
end
