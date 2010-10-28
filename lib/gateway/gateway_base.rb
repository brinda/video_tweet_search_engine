class GatewayBase
  def read_from_url(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.request(Net::HTTP::Get.new(uri.request_uri)).body
  end
end