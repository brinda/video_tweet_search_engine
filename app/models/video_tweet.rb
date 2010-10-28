class VideoTweet
  attr_accessor :user, :user_id, :text, :links
                                            
  def initialize(data = {})
    @user = data[:user]
    @user_id = data[:user_id]
    @text = data[:text]
    @links = data[:links]
  end

  def self.tweets(search_phrase)
    response = TwitterGateway.new.search_response(search_phrase)
    results = ActiveSupport::JSON.decode(response)["results"]
    results.collect do |result|
      text = result["text"]
      links = LinkParser.extract_link(text)
      VideoTweet.new(:user => result["from_user"], :user_id => result["from_user_id"], :text => text, :links => links)
    end
  end
end