module OauthTwitter
  module API
    module Friends
      PATH = {
        friends_ids: '/1.1/friends/ids.json'
      }

      def friends_ids(user_id)
        oauth = oauth_params(true)
        query = {
          user_id: user_id,
          count: 5000
        }
        return send_request(:GET, PATH[:friends_ids], query, oauth)
      end

    end
  end
end
