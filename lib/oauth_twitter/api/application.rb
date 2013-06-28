module OauthTwitter
  module API
    module Application
      PATH = {
        :rate_limit_status => '/1.1/application/rate_limit_status.json'
      }

      def rate_limit_status(params={}, options={})
        return send_request(:GET, PATH[:rate_limit_status], params, true, options)
      end

    end
  end
end