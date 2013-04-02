module OauthTwitter
  module API
    module Statuses
      PATH = {
        home_timeline: "/1.1/statuses/home_timeline.json"
      }
      
      def home_timeline(since_id=nil)
        oauth = oauth_params(true)
        query = {
          count: 200,
          trim_user: false,
          exclude_replies: true,
          contributor_details: false,
          include_entities: true
        }
        query[:since_id] = since_id if since_id
        return send_request(:GET, PATH[:home_timeline], query, oauth)
      end
      
    end
  end
end
