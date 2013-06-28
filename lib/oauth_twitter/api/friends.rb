module OauthTwitter
  module API
    module Friends
      PATH = {
        :friendships_no_retweets_ids => '/1.1/friendships/no_retweets/ids.json',
        :friends_ids                 => '/1.1/friends/ids.json',
        :followers_ids               => '/1.1/followers/ids.json',
        :friendships_lookup          => '/1.1/friendships/lookup.json',
        :friendships_incoming        => '/1.1/friendships/incoming.json',
        :friendships_outgoing        => '/1.1/friendships/outgoing.json',
        :friendships_create          => '/1.1/friendships/create.json',
        :friendships_destroy         => '/1.1/friendships/destroy.json',
        :friendships_update          => '/1.1/friendships/update.json',
        :friendships_show            => '/1.1/friendships/show.json',
        :friends_list                => '/1.1/friends/list.json',
        :followers_list              => '/1.1/followers/list.json'
      }

      def friendships_no_retweets_ids(params={}, options={})
        return send_request(:GET, PATH[:friendships_no_retweets_ids], params, true, options)
      end

      def friends_ids(params={}, options={})
        return send_request(:GET, PATH[:friends_ids], params, true, options)
      end

      def followers_ids(params={}, options={})
        return send_request(:GET, PATH[:followers_ids], params, true, options)
      end

      def friendships_lookup(params={}, options={})
        return send_request(:GET, PATH[:friendships_lookup], params, true, options)
      end

      def friendships_incoming(params={}, options={})
        return send_request(:GET, PATH[:friendships_incoming], params, true, options)
      end

      def friendships_outgoing(params={}, options={})
        return send_request(:GET, PATH[:friendships_outgoing], params, true, options)
      end

      def friendships_create(params={}, options={})
        return send_request(:GET, PATH[:friendships_create], params, true, options)
      end

      def friendships_destroy(params={}, options={})
        return send_request(:GET, PATH[:friendships_destroy], params, true, options)
      end

      def friendships_update(params={}, options={})
        return send_request(:GET, PATH[:friendships_update], params, true, options)
      end

      def friendships_show(params={}, options={})
        return send_request(:GET, PATH[:friendships_show], params, true, options)
      end

      def friends_list(params={}, options={})
        return send_request(:GET, PATH[:friends_list], params, true, options)
      end

      def followers_list(params={}, options={})
        return send_request(:GET, PATH[:followers_list], params, true, options)
      end

    end
  end
end
