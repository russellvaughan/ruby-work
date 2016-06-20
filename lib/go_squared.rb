require 'net/http'
require 'json'

class GoSquared

	BASEURL = "https://api.gosquared.com/trends/v2/"
	METRICS = ['aggregate', 'browser', 'category', 'country', 'event', 'language', 'organisation', 'os', 'page', 'path', 'screenDimensions', 'sources', 'transaction']
	
	def initialize(api_key="demo", site_token="GSN-181546-E")
		@site_token = site_token
		@api_key = api_key
		@metric = "aggregate?"
		@params = {dateFormat: @dateFormat, from: @from, to: @to, 
			format: @format, limit: @limit, sort: @sort, group: @group}
		end

		METRICS.each do |metric|
			define_method metric do
				@metric = metric + "?"
			end
		end

		def fetch
			uri = URI(@url)
			response = Net::HTTP.get(uri)
			@data = JSON.parse(response)
		end

		def build_params
			@array = ['&']
			@params.each do |key, value|
				@array << "#{key}=#{value}" if value
			end
			filter=@array.join('&')
			@url = @url.concat(filter)
		end

		def build_url
			@url = BASEURL + @metric + "api_key=#{@api_key}" + "&site_token=#{@site_token}"
			self
		end

		def from(date)
			@from = @params[:from]=date
			self
		end

		def to(date)
			@end = @params[:to]=date
			self
		end

		def date_format(format)
			@dateFormat = @params[:dateFormat]=format
			self
		end

		def limit(amount)
			@limit = @params[:limit]=amount
			self
		end

		def sort(by)
			@sort = @params[:sort]=by
			self
		end

		def group(by)
			@group =@params[:group]=by
			self
		end

	end

"https://api.gosquared.com/trends/v2/aggregate?api_key=demo&site_token=GSN-181546-E&dateFormat=yyyymmdd&from=20160614&to=20160615" 
