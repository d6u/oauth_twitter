module OauthTwitter
  module Config
    class << self
      attr_accessor :consumer_key, :consumer_secret, :oauth_callback
      
      def setup
        yield self
      end
    end
  end
end
