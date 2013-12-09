require "net/http"
require "uri"
require 'json'

class Object
  
  @headers == nil

  def blank?
      respond_to?(:empty?) ? empty? : !self
    end

    def present?
      !blank?
    end

  def header key, value
    if @headers == nil
      @headers = Hash.new(0)
    end

    @headers[key] = value
  end

  def request path,request_opts
    req = "#{$SERVER_PATH}" + path
    
    uri = URI.parse(req)
    http = Net::HTTP.new(uri.host, uri.port)

    if request_opts[:method] == :post
      request = Net::HTTP::Post.new(uri.request_uri)

      body = nil
      if request_opts[:params]
        body = request_opts[:params].to_json
      else
        body = request_opts[:input]
      end
    else 
      request = Net::HTTP::Get.new(uri.request_uri)
    end

    #do we have any headers to add?
    if @headers != nil
      @headers.each { |k,v| request.add_field(k, v) }
      @headers = nil
    end

    @response = http.request(request,body)
  end

  def last_response
    return @response
  end

end