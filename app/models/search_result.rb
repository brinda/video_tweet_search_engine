class SearchResult
  attr_accessor :video_tweet, :video_info

  def initialize(video_tweet, video_info)
    @video_tweet = video_tweet
    @video_info = video_info
  end
end