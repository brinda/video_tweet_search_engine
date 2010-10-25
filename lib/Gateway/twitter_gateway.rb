#module Gateway
  class TwitterGateway
    SEARCH_URL = "http://search.twitter.com/search.json"

    def self.query_url(search_phrase)
      "#{SEARCH_URL}?q=&ands=#{encode(search_phrase)}&ors=youtube+bit&filter[]=links&rpp=100&page=1"
    end

    def self.connect_to_twitter()
      uri = URI.parse(query_url('Metallica'))
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.request(Net::HTTP::Get.new(uri.request_uri))
    end

     def self.result_length(response)
       result = get_result(response).size
       puts result
       result
     end

    def self.extract_text(result)
        res_text=[]
        get_result(result).each do |var|
          res_text.push(var['text'])
        end
      res_text
    end

    def self.extract_link(text)
      link = ""
      words = text.split(" ")
      words.each do |word|
        if(word.start_with?("http://www.youtube.com"))
          link = word
          break
        end
      end
      link
    end

    private
    def self.encode(query_string)
      CGI::escape query_string
    end

    def self.get_result(response)
      result = ActiveSupport::JSON.decode(response.body)["results"]
    end

  end
#end