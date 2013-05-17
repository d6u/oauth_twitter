module OauthTwitter
  module API
    module Users
      PATH = {
        :users_lookup         => '/1.1/users/lookup.json',
        :users_show           => '/1.1/users/show.json',
        :users_search         => '/1.1/users/search.json',
        :users_contributees   => '/1.1/users/contributees.json',
        :users_contributors   => '/1.1/users/contributors.json',
        :users_profile_banner => '/1.1/users/profile_banner.json'
      }

      ##
      # @param params [Hash] :screen_name => Array, :user_id => Array,
      #   :include_entities => Boolean
      def users_lookup(params, options={})
        query = params.clone
        users_array = query[:screen_name] || query[:user_id]
        users_array_type = (query[:screen_name]) ? :screen_name : :user_id
        # slice id_array for multiple request
        num_of_set = users_array.size / 100
        num_of_set += 1 if users_array.size % 100 > 0
        id_sets = num_of_set.times.map {|i| users_array.slice(i*100, (i+1)*100)}
        # send request
        full_response = []
        response = nil
        id_sets.each do |set|
          oauth = oauth_params(true)
          query[users_array_type] = set.join(',')
          method = set.size <= 10 ? :GET : :POST
          response = send_request(method, PATH[:users_lookup], query, oauth)
          if response[0]
            full_response += response[1]
          else
            break
          end
        end
        return results_with_error_explained(response, options, full_response)
      end

      def users_show

      end

      def users_search

      end

      def users_contributees

      end

      def users_contributors

      end

      def users_profile_banner

      end

    end
  end
end
