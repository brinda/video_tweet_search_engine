class LinkParser
  LinkRegex =  /(http:\/\/www.youtube.com\/.*?\s|http:\/\/bit.ly\/[a-zA-Z0-9]+)/
  def self.extract_link(text)
    links = text.scan(LinkRegex).flatten.collect { |link| link.strip }
    links.flatten
  end
end