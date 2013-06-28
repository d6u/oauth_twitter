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
          query[users_array_type] = set.join(',')
          method = set.size <= 10 ? :GET : :POST
          response = send_request(method, PATH[:users_lookup], query, true)
          if response[:valid]
            full_response += response[:data]
          else
            break
          end
        end

        # return
        return assemble_multi_page_response(full_response, response, options)
      end

      def users_show(params, options={})
        return send_request(:GET, PATH[:users_show], params, true, options)
      end

      def users_search(params, options={})
        return send_request(:GET, PATH[:users_search], params, true, options)
      end

      def users_contributees(params, options={})
        return send_request(:GET, PATH[:users_contributees], params, true, options)
      end

      def users_contributors(params, options={})
        return send_request(:GET, PATH[:users_contributors], params, true, options)
      end

      def users_profile_banner(params={}, options={})
        return send_request(:GET, PATH[:users_profile_banner], params, true, options)
      end

    end
  end
end
