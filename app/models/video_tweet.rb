class VideoTweet
  attr_accessor :user, :user_id, :text

  def initialize(data = {})
    @user = data[:user]
    @user_id = data[:user_id]
    @text = data[:text]
  end

  def self.tweets(search_phrase)
    response = TwitterGateway.new.search_response(search_phrase)
    results = ActiveSupport::JSON.decode(response)["results"]
    results.collect do |result|
      VideoTweet.new(:user => result["from_user"], :user_id => result["from_user_id"], :text => result["text"])
    end
  end
end