require 'net/http'
require 'net/https'
require 'uri'
require 'json'

class GoSquared
	
	class Tracking 

		BASEURL = "https://api.gosquared.com/tracking/v1/identify?"

		def initialize(api_key="1F6DLEGZKZ2QUK48", site_token="GSN-086224-W")
			@site_token = site_token
			@api_key = api_key
		end

		def identify(options={})
			@data = options
		end

		def post
			uri = URI.parse(url)
			https = Net::HTTP.new(uri.host, uri.port)
			https.use_ssl = true
			request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
			request.body = "[ #{@data.to_json} ]"
			response = https.request(request)
			puts "Response #{response.code} #{response.message}: #{response.body}"
		end

		def url
			@url = BASEURL + "api_key=#{@api_key}" + "&site_token=#{@site_token}"
		end

	end 
end