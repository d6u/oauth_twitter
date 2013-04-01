module OauthTwitter
  module API
    module Users
      PATH = {
        users_lookup: "/1.1/users/lookup.json"
      }
      
      def users_lookup(id_array, include_entities=true)
        oauth = oauth_params(true)
        # slice id_array for multiple request
        num_of_set = id_array.size / 100
        num_of_set += 1 if id_array.size % 100 > 0
        id_sets = num_of_set.times.map {|i| id_array.slice(i*100, (i+1)*100)}
        # send request
        result = []
        id_sets.each do |set|
          query = {
            user_id: set.join(','),
            include_entities: include_entities
          }
          method = set.size <= 10 ? :GET : :POST
          result += send_request(method, PATH[:users_lookup], query, oauth)
        end
        return result
      end
      
    end
  end
end
