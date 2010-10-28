class VideoTweetTest  < ActiveSupport::TestCase
  def setup
    @search_phrase = "Metallica"
    @video_tweet = VideoTweet.new
  end

  test "tweets should return all matching video tweets" do
    tweets = VideoTweet.tweets(@search_phrase)
    assert_not_nil(tweets)
    assert_equal(100, tweets.size)
    tweets.each do |video_tweet|
      assert_not_nil(video_tweet)
      assert(video_tweet.kind_of?(VideoTweet))
    end
  end
end