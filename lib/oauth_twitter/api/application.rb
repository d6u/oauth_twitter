module OauthTwitter
  module API
    module Application
      PATH = {
        :rate_limit_status => '/1.1/application/rate_limit_status.json'
      }

      def rate_limit_status(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:rate_limit_status], query, oauth)
        return results_with_error_explained(response, options)
      end

    end
  end
end