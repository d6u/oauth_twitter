module OauthTwitter
  module API
    module Friends
      PATH = {
        :friendships_no_retweets_ids => '/1.1/friendships/no_retweets/ids.json',
        :friends_ids                 => '/1.1/friends/ids.json',
        :followers_ids               => '/1.1/followers/ids.json',
        :friendships_lookup          => '/1.1/friendships/lookup.json',
        :friendships_incoming        => '/1.1/friendships/incoming.json',
        :friendships_outgoing        => '/1.1/friendships/outgoing.format',
        :friendships_create          => '/1.1/friendships/create.json',
        :friendships_destroy         => '/1.1/friendships/destroy.json',
        :friendships_update          => '/1.1/friendships/update.json',
        :friendships_show            => '/1.1/friendships/show.json',
        :friends_list                => '/1.1/friends/list.json',
        :followers_list              => '/1.1/followers/list.json'
      }

      def friendships_no_retweets_ids(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:friendships_no_retweets_ids], query, oauth)
        return results_with_error_explained(response, options)
      end

      def friends_ids(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:friends_ids], query, oauth)
        return results_with_error_explained(response, options)
      end

      def followers_ids(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:followers_ids], query, oauth)
        return results_with_error_explained(response, options)
      end

      def friendships_lookup(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:friendships_lookup], query, oauth)
        return results_with_error_explained(response, options)
      end

      def friendships_incoming(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:friendships_incoming], query, oauth)
        return results_with_error_explained(response, options)
      end

      def friendships_outgoing(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:friendships_outgoing], query, oauth)
        return results_with_error_explained(response, options)
      end

      def friendships_create(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:POST, PATH[:friendships_create], query, oauth)
        return results_with_error_explained(response, options)
      end

      def friendships_destroy(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:POST, PATH[:friendships_destroy], query, oauth)
        return results_with_error_explained(response, options)
      end

      def friendships_update(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:POST, PATH[:friendships_update], query, oauth)
        return results_with_error_explained(response, options)
      end

      def friendships_show(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:friendships_show], query, oauth)
        return results_with_error_explained(response, options)
      end

      def friends_list(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:friends_list], query, oauth)
        return results_with_error_explained(response, options)
      end

      def followers_list(params={}, options={})
        query = params.clone
        oauth = oauth_params(true)
        response = send_request(:GET, PATH[:followers_list], query, oauth)
        return results_with_error_explained(response, options)
      end

    end
  end
end
