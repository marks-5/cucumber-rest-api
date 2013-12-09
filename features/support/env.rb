require 'cucumber'
require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support

require "net/http"
require "uri"
require 'json'

class Object
	
	SERVER_PATH = "http://localhost:3123"

	def blank?
    	respond_to?(:empty?) ? empty? : !self
  	end

  	def present?
    	!blank?
  	end

	def request path,request_opts
		req = "#{SERVER_PATH}" + path
		uri = URI.parse(req)
		http = Net::HTTP.new(uri.host, uri.port)

		request = Net::HTTP::Post.new(uri.request_uri)

		body = nil

		if request_opts[:params]
			body = request_opts[:params].to_json
		else
			body = request_opts[:input]
		end

		@response = http.request(request,body)
	end

	def last_response
		return @response
	end

end