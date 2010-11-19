class VideoInfo
  attr_accessor :title, :embed_link, :thumbnail_image_url

  def initialize(data = {})
    @title = data[:title]
    @embed_link = data[:embed_link]
    @thumbnail_image_url = data[:thumbnail_image_url]
    @you_tube_link = data[:you_tube_link]
  end

  def self.find(url)
    # Use youtube gateway class to get video_title, video_embed_link and thumbnail_image_url
    # then
    VideoInfo.new(:title => video_title, :embed_link => embed_link, :thumbnail_image_url => thumbnail_image_url)
  end

end