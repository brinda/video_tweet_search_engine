class SearchEngine
  def self.search(search_phrase)
    tweets = VideoTweet.tweets(search_phrase)
    url_resolver_factory = UrlResolverFactory.new

    tweets.inject([]) do |search_results, tweet|
      you_tube_video_urls = tweet.links.collect do |link|
        resolver = url_resolver_factory.resolver_for(link)
        resolver.resolve(link)
      end.compact

      you_tube_video_urls.each do |you_tube_link|
        video_info = VideoInfo.find(you_tube_link) if you_tube_link != nil
        search_results << SearchResult.new(tweet, video_info)
      end
    end

  end
end