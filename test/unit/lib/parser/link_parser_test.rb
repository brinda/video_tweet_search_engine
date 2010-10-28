require 'test_helper'

class LinkParserTest  < ActiveSupport::TestCase
  test "links extracted out of text" do
    links = LinkParser.extract_link("some text with youtube link http://www.youtube.com/watch?v=YgW7or1TuFk and http://www.youtube.com/watch?v=kN0SVBCJqLs and bit.ly link http://bit.ly/aqrOCO and http://bit.ly/aqrODO here")
    assert_equal(4, links.size)
    assert_includes(links, "http://www.youtube.com/watch?v=YgW7or1TuFk")
    assert_includes(links, "http://www.youtube.com/watch?v=kN0SVBCJqLs")
    assert_includes(links, "http://bit.ly/aqrOCO")
    assert_includes(links, "http://bit.ly/aqrODO")
  end
end
