require 'jsonpath'
require 'nokogiri'

require 'cucumber'
require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support

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

Given /^I set headers:$/ do |headers|
  headers.rows_hash.each {|k,v| header k, v }
end

Given /^I send and accept (XML|JSON)$/ do |type|
  header 'Accept', "application/#{type.downcase}"
  header 'Content-Type', "application/#{type.downcase}"
end

Given /^I send and accept HTML$/ do
  header 'Accept', "text/html"
  header 'Content-Type', "application/x-www-form-urlencoded"
end

When /^I authenticate as the user "([^"]*)" with the password "([^"]*)"$/ do |user, pass|
  authorize user, pass
end

When /^I digest\-authenticate as the user "(.*?)" with the password "(.*?)"$/ do |user, pass|
  digest_authorize user, pass
end

When /^I send a (GET|POST|PUT|DELETE) request (?:for|to) "([^"]*)"(?: with the following:)?$/ do |*args|
  request_type = args.shift
  path = args.shift
  input = args.shift

  request_opts = {method: request_type.downcase.to_sym}

  unless input.nil?
    if input.class == Cucumber::Ast::Table
      request_opts[:params] = input.rows_hash
    else
      request_opts[:input] = input
    end
  end

  request path, request_opts
end

Then /^show me the (unparsed)?\s?response$/ do |unparsed|
  if unparsed == 'unparsed'
    puts last_response.body
  elsif last_response.headers['Content-Type'] =~ /json/
    json_response = JSON.parse(last_response.body)
    puts JSON.pretty_generate(json_response)
  elsif last_response.headers['Content-Type'] =~ /xml/
    puts Nokogiri::XML(last_response.body)
  else
    puts last_response.headers
    puts last_response.body
  end
end

Then /^the response status should be "([^"]*)"$/ do |status|
  if self.respond_to? :should
    last_response.code.should == status
  else
    assert_equal status, last_response.code
  end
end

Then /^the JSON response should (not)?\s?have "([^"]*)"$/ do |negative, json_path|
  json    = JSON.parse(last_response.body)
  results = JsonPath.new(json_path).on(json).to_a.map(&:to_s)
  if self.respond_to?(:should)
    if negative.present?
      results.should be_empty
    else
      results.should_not be_empty
    end
  else
    if negative.present?
      assert results.empty?
    else
      assert !results.empty?
    end
  end
end


Then /^the JSON response should (not)?\s?have "([^"]*)" with the text "([^"]*)"$/ do |negative, json_path, text|
  json    = JSON.parse(last_response.body)
  results = JsonPath.new(json_path).on(json).to_a.map(&:to_s)
  if self.respond_to?(:should)
    if negative.present?
      results.should_not include(text), "Expected #{text}, Got #{results}"
    else
      results.should include(text) , "Expected #{text}, Got #{results}"
    end
  else
    if negative.present?
      assert !results.include?(text), "Expected #{text}, Got #{results}"
    else
      assert results.include?(text), "Expected #{text}, Got #{results}"
    end
  end
end

Then /^the XML response should (not)?\s?have "([^"]*)"$/ do |negative, xpath|
  parsed_response = Nokogiri::XML(last_response.body)
  elements = parsed_response.xpath(xpath)
  if self.respond_to?(:should)
    if negative.present?
      elements.should be_empty
    else
      elements.should_not be_empty
    end
  else
    if negative.present?
      assert elements.empty?
    else
      assert !elements.empty?
    end
  end
end

Then /^the XML response should have "([^"]*)" with the text "([^"]*)"$/ do |xpath, text|
  parsed_response = Nokogiri::XML(last_response.body)
  elements = parsed_response.xpath(xpath)
  if self.respond_to?(:should)
    elements.should_not be_empty, "could not find #{xpath} in:\n#{last_response.body}"
    elements.find { |e| e.text == text }.should_not be_nil, "found elements but could not find #{text} in:\n#{elements.inspect}"
  else
    assert !elements.empty?, "could not find #{xpath} in:\n#{last_response.body}"
    assert elements.find { |e| e.text == text }, "found elements but could not find #{text} in:\n#{elements.inspect}"
  end
end

Then /^the JSON response should be:$/ do |json|
  expected = JSON.parse(json)
  actual = JSON.parse(last_response.body)

  if self.respond_to?(:should)
    actual.should == expected
  else
    assert_equal actual, response
  end
end

Then /^the JSON response should have "([^"]*)" with a length of (\d+)$/ do |json_path, length|
  json = JSON.parse(last_response.body)
  results = JsonPath.new(json_path).on(json)
  if self.respond_to?(:should)
    results.length.should == length.to_i
  else
    assert_equal length.to_i, results.length
  end
end