require "net/http"
require "net/https"
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

   def last_response
    return @response
  end

  def request path,request_opts
    req = "#{$SERVER_PATH}" + path
    uri = URI.parse(req)

    http = Net::HTTP.new(uri.host, uri.port)

    if request_opts[:method] == :post
          request, body = send_post_request(uri, request_opts)
    elsif request_opts[:method] == :put
          request, body  = perform_put_request(uri, request_opts)     
    elsif request_opts[:method] == :get
          request = send_get_request(uri, request_opts)
    elsif request_opts[:method] == :delete
          request = perform_delete_request(uri, request_opts)
    end

    #do we have any headers to add?
    if @headers != nil
      @headers.each { |k,v| request.add_field(k, v) }
      @headers = nil
    end

    if req.include? "https" 
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE  
        @response = http.request(request,body)
    else  
       http = Net::HTTP.new(uri.host, uri.port)
       @response = http.request(request,body)
    end
  end

 
  def send_post_request uri,request_opts
    request = Net::HTTP::Post.new(uri.request_uri)
    body = nil
    if request_opts[:params]
      body = request_opts[:params].to_json
    else
      body = request_opts[:input]
    end
    return request, body
  end

  def perform_put_request uri,request_opts
    request = Net::HTTP::Put.new(uri.request_uri)
    body = nil
    if request_opts[:params]
        body = request_opts[:params].to_json
    else
        body = request_opts[:input]
    end
    return request, body
  end

  def send_get_request uri,request_opts
    request = Net::HTTP::Get.new(uri.request_uri)
    return request
  end

  
  def perform_delete_request uri,request_opts
    request = Net::HTTP::Delete.new(uri.request_uri)
    return request
  end

end
