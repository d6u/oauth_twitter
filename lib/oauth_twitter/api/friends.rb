module OauthTwitter
  module API
    module Friends
      PATH = {
        friends_ids: '/1.1/friends/ids.json'
      }

      def friends_ids(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:friends_ids], query, oauth)
        return explain_error(response, options, response)
      end

    end
  end
end
