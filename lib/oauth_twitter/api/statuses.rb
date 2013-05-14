module OauthTwitter
  module API
    module Statuses
      PATH = {
        home_timeline: "/1.1/statuses/home_timeline.json"
      }

      ##
      # Load current use's (determined by oauth_token and oauth_token_secret
      # variables) home time.
      #
      # @param params [Hash] parameters that consistent with Twitter's API.
      # @param args [Hash] options to perform more operations.
      #
      #   :pages => [Int] indicate many pages will return, for example,
      #   if count = 5, pages = 3, then it will return 5 * 3 = 15 tweets
      #   from the user's timeline. Cursor stops if response hit since_id.
      #
      # @return [Hash] hash structured the same as Twitter's JSON response.
      def home_timeline(params={}, args={})
        query = {}
        query[:count]               = params[:count] unless params[:count].nil?
        query[:since_id]            = params[:since_id] unless params[:since_id].nil?
        query[:max_id]              = params[:max_id] unless params[:max_id].nil?
        query[:trim_user]           = params[:trim_user] unless params[:trim_user].nil?
        query[:exclude_replies]     = params[:exclude_replies] unless params[:exclude_replies].nil?
        query[:contributor_details] = params[:contributor_details] unless params[:contributor_details].nil?
        query[:include_entities]    = params[:include_entities] unless params[:include_entities].nil?

        full_response = []
        args[:pages] ||= 1
        args[:pages].times do |page_num|
          oauth = oauth_params(true)
          response = send_request(:GET, PATH[:home_timeline], query, oauth)
          break if response.empty?
          full_response += response
          query[:max_id] = response.last['id'] - 1
        end

        return full_response
      end

    end
  end
end
