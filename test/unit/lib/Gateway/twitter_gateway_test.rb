require 'test_helper'
require "net/http"
require "uri"

module Gateway
  class TwitterGatewayTest < ActiveSupport::TestCase
    def setup
    end

    test "Should form the twitter search query, Given the search phrase" do
      search_phrase = "metallica"
      query_url = TwitterGateway.query_url(search_phrase)
      expected_url = "#{TwitterGateway::SEARCH_URL}?q=&ands=metallica&ors=youtube+bit&filter[]=links&rpp=100&page=1"
      assert_equal(expected_url, query_url)
    end

    test "Should encode url" do
      search_phrase = "metallica + pinkfloyd, tom & jerry"
      query_url = TwitterGateway.query_url(search_phrase)
      expected_url = "#{TwitterGateway::SEARCH_URL}?q=&ands=metallica+%2B+pinkfloyd%2C+tom+%26+jerry&ors=youtube+bit&filter[]=links&rpp=100&page=1"
     assert_equal(expected_url, query_url)
    end

    test "Connection to the Twitter should return a response" do
      response = TwitterGateway.connect_to_twitter()
      assert_not_nil(response, "No response from Twitter")
    end

    test "Response has maximum of 100 results" do
      response = TwitterGateway.connect_to_twitter()
      assert_equal(TwitterGateway.result_length(response) <=100, true)
      assert_not_nil(response, "No response from Twitter")
    end

    test "extract twitter post retrieves the text" do
        response = TwitterGateway.connect_to_twitter()
        twitter_result  = TwitterGateway.extract_text(response)
        twitter_result.each do |result|
          assert_not_nil(result)
        end
    end

    test "links extracted out of text are proper" do
      assert_equal("http://www.youtube.com", TwitterGateway.extract_link("this is a link to http://www.youtube.com"))
      assert_equal("", TwitterGateway.extract_link("this is a link to http://youtube.com"))
      assert_equal("", TwitterGateway.extract_link("this is a link to http://google.com"))
      assert_equal("", TwitterGateway.extract_link("this is a link to nothing"))

    end
  end
end

 