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
      #   :explain_error => [Bool] if true, will return a HTTP Code indicate
      #   the error
      #
      # @return [Hash] hash structured the same as Twitter's JSON response.
      #
      #   if :explain_error => true, will return array like:
      #   [json, response.body, response.code]
      def home_timeline(params={}, options={})
        query = params.clone
        full_response = []
        response = nil
        options[:pages] ||= 1
        options[:pages].times do |page_num|
          oauth = oauth_params(true)
          response = send_request(:GET, PATH[:home_timeline], query, oauth)
          break unless response[0]
          break if response[1].empty?
          full_response += response[1]
          query[:max_id] = response[1].last['id'] - 1
        end
        if options[:explain_error] == true
          return full_response, response[1], response[2]
        else
          return full_response
        end
      end

    end
  end
end
