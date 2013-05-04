require "securerandom"
require "openssl"
require "base64"
require "uri"
require "net/http"
require "multi_json"

module OauthTwitter
  module Helper
    def oauth_params(include_oauth_token=true, addional_oauth_params={})
      oauth = {
        oauth_consumer_key: Config.consumer_key,
        oauth_nonce: SecureRandom.hex(21),
        oauth_signature_method: "HMAC-SHA1",
        oauth_timestamp: Time.now.to_i,
        oauth_version: "1.0"
      }
      oauth[:oauth_token] = self.oauth_token if include_oauth_token
      return oauth.merge(addional_oauth_params)
    end

    RESERVED_CHARS = /[^a-zA-Z0-9\-\.\_\~]/
    def self.percent_encode(raw)
      return URI.escape(raw.to_s, RESERVED_CHARS)
    end

    HOST = "https://api.twitter.com"
    def send_request(method, path, query, oauth)
      # Make base_str and signing_key
      base_str = method.to_s.upcase << "&"
      base_str << Helper.percent_encode(HOST + path) << "&"
      hash = query ? oauth.merge(query) : oauth
      array = hash.sort.map {|key, val| Helper.percent_encode(key) + "=" + Helper.percent_encode(val)}
      base_str << Helper.percent_encode(array.join("&"))
      # Sign
      signing_key = String.new(Config.consumer_secret) << "&"
      signing_key << self.oauth_token_secret if hash[:oauth_token]
      signature = Helper.sign(base_str, signing_key)
      signed_oauth = oauth.merge(oauth_signature: signature)
      # Header
      auth_header = Helper.auth_header(signed_oauth)
      # HTTP request
      uri = URI.parse(HOST + path)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      case
      when method.to_s.upcase == "POST"
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data(query) if query
      when method.to_s.upcase == "GET"
        uri.query = URI.encode_www_form(query) if query
        request = Net::HTTP::Get.new(uri.request_uri)
      end
      request["Authorization"] = auth_header
      # Response
      begin
        response = https.request(request)
      rescue SocketError
        return false
      end
      case response.code
      when "200"
        begin
          return MultiJson.load(response.body)
        rescue MultiJson::LoadError
          return Rack::Utils.parse_nested_query(response.body)
        end
      when "401"
        return false
      when "408"
        return false
      else
        p response.code, response.body
        raise "HTTP request failed."
      end
    end

    def self.sign(base_str, signing_key)
      hex_str = OpenSSL::HMAC.hexdigest(
        OpenSSL::Digest::Digest.new('sha1'),
        signing_key,
        base_str)
      binary_str = Base64.encode64( [hex_str].pack("H*") ).gsub(/\n/, "")
      return Helper.percent_encode( binary_str )
    end

    def self.auth_header(signed_oauth)
      params = signed_oauth.map { |key, val| "#{key}=\"#{val}\"" }
      return "OAuth " << params.join(",")
    end
  end
end
