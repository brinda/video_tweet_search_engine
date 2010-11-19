class UrlResolverFactory
  def initialize()
    @you_tube_url_resolver = YouTubeUrlResolver.new
    @bit_url_resolver = BitUrlResolver.new
  end

  def resolver_for(url)
    return @bit_url_resolver if url =~ /bit\.ly/i
    
    return @you_tube_url_resolver
  end
end