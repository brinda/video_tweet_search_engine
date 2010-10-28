require 'test_helper'
require "net/http"
require "uri"

#module Gateway
  class TwitterGatewayTest < ActiveSupport::TestCase
    def setup
      @search_phrase = 'Metallica'
      @twitter_gateway = TwitterGateway.new
    end

    test "Should form the twitter search query, Given the search phrase" do
      query_url = @twitter_gateway.query_url(@search_phrase)
      expected_url = "#{TwitterGateway::SEARCH_URL}?q=&ands=#{@search_phrase}&ors=youtube+bit&filter[]=links&rpp=100&page=1"
      assert_equal(expected_url, query_url)
    end

    test "Should encode url" do
      search_phrase = "metallica + pinkfloyd, tom & jerry"
      query_url = @twitter_gateway.query_url(search_phrase)
      expected_url = "#{TwitterGateway::SEARCH_URL}?q=&ands=metallica+%2B+pinkfloyd%2C+tom+%26+jerry&ors=youtube+bit&filter[]=links&rpp=100&page=1"
      assert_equal(expected_url, query_url)
    end

    test "Search should return a response" do
      response = @twitter_gateway.search_response(@search_phrase)
      assert_not_nil(response, "No response from Twitter")
    end

    test "extract bit links retrieves bit links" do
#      assert_equal("http://bit.ly/", TwitterGateway.extract_bit_link("this is a link to http://bit.ly"))
#      assert_equal("", TwitterGateway.extract_bit_link("this is a link to http://www.youtube.com"))
    end
  end
#end

 