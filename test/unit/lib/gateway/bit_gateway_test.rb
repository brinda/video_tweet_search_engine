require 'test_helper'
require "net/http"
require "uri"

#module Gateway
  class BitGatewayTest < ActiveSupport::TestCase
    def setup
      @shortUrl = 'http://bit.ly/ay83h2'
      @bit_gateway = BitGateway.new
    end

    test "bit expands the short url given" do
      expected_long_url = 'http://www.youtube.com/watch?v=owTmJrtD7g8&feature=related'
      response = @bit_gateway.response(@shortUrl)
      assert_not_nil(response)
    end

    test "bit expand returns a valid response" do
      expected_long_url = 'http://www.youtube.com/watch?v=owTmJrtD7g8&feature=related'
      response = @bit_gateway.response(@shortUrl)
      response = @bit_gateway.response(@shortUrl)
      assert_equal(200, @bit_gateway.read_status_code_from_response(response))
      assert_equal("OK", @bit_gateway.read_status_text_from_response(response))
    end

    test "bit expand returns an error when url not found" do
      short_url = 'http://bit.ly/thisappiscrazy'
      response = @bit_gateway.response(short_url)
      assert_equal(200, @bit_gateway.read_status_code_from_response(response))
      assert_equal("OK", @bit_gateway.read_status_text_from_response(response))
      assert_equal("NOT_FOUND", @bit_gateway.read_error_from_response(response))
    end

    test "bit expand returns a valid response when url found" do
      expected_long_url = 'http://www.youtube.com/watch?v=owTmJrtD7g8&feature=related'
      response = @bit_gateway.response(@shortUrl)
      assert_equal(expected_long_url, @bit_gateway.read_long_url_from_response(response))
    end
end