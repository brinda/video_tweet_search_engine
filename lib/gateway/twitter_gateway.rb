#module Gateway
  class TwitterGateway < GatewayBase
    SEARCH_URL = "http://search.twitter.com/search.json"

    def query_url(search_phrase)
      "#{SEARCH_URL}?q=&ands=#{encode(search_phrase)}&ors=youtube+bit&filter[]=links&rpp=100&page=1"
    end

    def search_response(search_phrase)
      query_url = query_url(search_phrase)
      read_from_url(query_url)
    end

     def self.result_length(response)
       result_body(response).size
     end

    def extract_text(results)
        result_body(results).collect do |result|
          result['text']
        end
    end

    private
    def encode(query_string)
      CGI::escape query_string
    end

    def result_body(response)
      ActiveSupport::JSON.decode(response)["results"]
    end

  end
#end