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
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:oauth_authenticate], query, oauth)
        return results_with_error_explained(response, options)
      end

      def oauth_authorize(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:oauth_authorize], query, oauth)
        return results_with_error_explained(response, options)
      end

      def oauth_access_token(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:POST, PATH[:oauth_access_token], query, oauth)
        return results_with_error_explained(response, options)
      end

      def oauth_request_token(params={}, options={})
        callback_url = params[:oauth_callback] || Config.oauth_callback
        oauth = oauth_params(false, {oauth_callback: callback_url})
        response = send_request(:POST, PATH[:oauth_request_token], nil, oauth)
        return results_with_error_explained(response, options)
      end

    end
  end
end
