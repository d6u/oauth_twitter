require "securerandom"
require "openssl"
require "base64"
require "uri"
require "net/http"
require "multi_json"

module OauthTwitter
  module Helper
    ##
    # Twitter API root url
    HOST = "https://api.twitter.com"

    ##
    # Package data and send oauth request
    #
    # oauth = true : true - include oauth token
    #                false - do not include oauth token
    #                [false, {hash}] - include additional params
    #
    # options = {} : :detailed => fasle - return false if request failed,
    #                    otherwise return just data
    # --------------------------------------------------
    def send_request(method, path, query, oauth=true, options={})
      # generate signing key
      signing_key_array = [ Config.consumer_secret ]

      # generate oauth params
      if !!oauth === oauth # boolean
        oauth_params = generate_oauth_params(oauth)
        signing_key_array.push((oauth ? self.oauth_token_secret : '' ))
      else
        oauth_params = generate_oauth_params(oauth[0], oauth[1])
        signing_key_array.push((oauth[0] ? self.oauth_token_secret : '' ))
      end

      # generate base string
      base_array = [ method.to_s.upcase, URI.encode_www_form_component(HOST + path), URI.encode_www_form_component(URI.encode_www_form((query ? oauth_params.merge(query) : oauth_params).sort)) ]

      # generate signature
      oauth_params[:oauth_signature] = sign(base_array, signing_key_array)

      # generate HTTP request
      uri = URI.parse(HOST + path)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      if method.to_s.upcase === 'GET'
        uri.query = URI.encode_www_form(query) if query
        request = Net::HTTP::Get.new(uri.request_uri)
      elsif method.to_s.upcase === 'POST'
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data(query) if query
      end
      request["Authorization"] = generate_oauth_header(oauth_params)

      # retrive response
      return parse_response(https.request(request), options)
    end


    # Protected
    # ==================================================
    protected

    ##
    # Generate oauth params
    #
    # --------------------------------------------------
    def generate_oauth_params(include_oauth_token=true, addional_oauth_params={})
      oauth = {
        :oauth_consumer_key     => Config.consumer_key,
        :oauth_nonce            => SecureRandom.hex(21),
        :oauth_signature_method => "HMAC-SHA1",
        :oauth_timestamp        => Time.now.to_i,
        :oauth_version          => "1.0"
      }
      oauth[:oauth_token] = self.oauth_token if include_oauth_token === true
      return oauth.merge(addional_oauth_params)
    end

    ##
    # Sign oauth params
    #
    # --------------------------------------------------
    def sign(base_array, signing_key_array)
      hex_str = OpenSSL::HMAC.hexdigest( OpenSSL::Digest::Digest.new('sha1'), signing_key_array.join('&'), base_array.join('&') )
      binary_str = Base64.encode64( [hex_str].pack("H*") ).gsub(/\n/, "")
      return URI.encode_www_form_component(binary_str)
    end

    ##
    # Generate header message for HTTP request
    #
    # --------------------------------------------------
    def generate_oauth_header(signed_oauth)
      return "OAuth " << signed_oauth.map {|key, val| "#{key}=\"#{val}\""}.join(",")
    end

    ##
    # Parse response for cleaner outputs
    #
    # --------------------------------------------------
    def parse_response(response, options={})
      result = {}
      begin
        result[:data] = MultiJson.load(response.body)
      rescue MultiJson::LoadError
        begin
          result[:data] = Hash[URI.decode_www_form(response.body)]
        rescue ArgumentError
          result[:data] = response.body
        end
      end

      if options[:detailed] === false
        return result[:data] if response.code === '200'
        return nil
      else
        result[:valid] = response.code === '200' ? true : false
        result[:code] = response.code.to_i
        return result
      end
    end

  end
end
