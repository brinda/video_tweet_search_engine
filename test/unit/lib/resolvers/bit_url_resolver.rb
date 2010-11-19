class BitUrlResolver

  
  def resolve(url)
    expanded_url = BitGateway.new.expanded_url(url)
    if(expanded_url != nil)
      extract_you_tube_url(expanded_url)
    end
  end

  private
    def extract_you_tube_url(expanded_url)
      links = LinkParser.extract_link(text)
      return links[0] if links.size > 0
    end
end