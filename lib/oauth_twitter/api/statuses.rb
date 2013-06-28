module OauthTwitter
  module API
    module Statuses

      ##
      # Url path of status API
      PATH = {
        :mentions_timeline => '/1.1/statuses/mentions_timeline.json',
        :user_timeline     => '/1.1/statuses/user_timeline.json',
        :home_timeline     => '/1.1/statuses/home_timeline.json',
        :retweets_of_me    => '/1.1/statuses/retweets_of_me.json'
      }

      ##
      # Load current user's Tweet with @user_name mentioned, include user
      # mention themselves.
      #
      # @param params [Hash] always supply a user_id or screen_name. If both
      #   are supplied, user_id will be used
      # @param options [Hash]
      #
      # @return [Array]
      def mentions_timeline(params={}, options={})
        query = params.clone
        return send_status_request(:mentions_timeline, query, options)
      end

      ##
      #
      def user_timeline(params={}, options={})
        query = params.clone
        return send_status_request(:user_timeline, query, options)
      end

      ##
      # Load current use's (determined by oauth_token and oauth_token_secret
      # variables) home time.
      #
      # @param params [Hash] parameters that consistent with Twitter's API.
      # @param options [Hash] options to perform more operations.
      #
      #   :pages => [Int] indicate many pages will return, for example,
      #   if count = 5, pages = 3, then it will return 5 * 3 = 15 tweets
      #   from the user's timeline. Cursor stops if response no more reponse.
      #
      #   :detailed => [Bool] if false, will return just the data
      #
      # @return [Array] hash structured the same as Twitter's JSON response.
      def home_timeline(params={}, options={})
        query = params.clone
        return send_status_request(:home_timeline, query, options)
      end

      ##
      #
      def retweets_of_me(params={}, options={})
        query = params.clone
        return send_status_request(:retweets_of_me, query, options)
      end

      private
      ##
      # Private helper for each of the status API
      def send_status_request(api_symbol, query, options)
        full_response = []
        response = nil
        options[:pages] ||= 1
        options[:pages].times do |page_num|
          response = send_request(:GET, PATH[api_symbol], query, true, options)
          break unless response[:valid]
          break if response[:data].empty?
          full_response += response[:data]
          query[:max_id] = response[:data].last['id'] - 1
        end
        return assemble_multi_page_response(full_response, response, options)
      end

    end
  end
end
