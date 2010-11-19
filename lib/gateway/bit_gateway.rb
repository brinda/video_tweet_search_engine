class BitGateway < GatewayBase
  SEARCH_URL = "http://api.bit.ly/v3/expand"
  LOGIN_NAME = 'searchtweet'
  LOGIN_API_KEY = 'R_4a5ae5a6cac0bf5d28c79a8fbb908160'

  def query_url(short_url)
    "#{SEARCH_URL}?shortUrl=#{short_url}&login=#{LOGIN_NAME}&apiKey=#{LOGIN_API_KEY}&format=json"
  end

  def response(short_url)
    query_url = query_url(short_url)
    read_from_url(query_url)
  end

  def read_status_code_from_response(response)
    ActiveSupport::JSON.decode(response)["status_code"]
  end

  def read_status_text_from_response(response)
    ActiveSupport::JSON.decode(response)["status_txt"]
  end

  def read_long_url_from_response(response)
    result = ActiveSupport::JSON.decode(response)
      return resp = result["data"]["expand"][0]["long_url"] if (result["status_code"] == 200)
    return nil
  end

  def read_error_from_response(response)
    data = ActiveSupport::JSON.decode(response)["data"]
    data["expand"][0]["error"]
  end

  def expanded_url(short_url)
    read_long_url_from_response(response(short_url))
  end

end