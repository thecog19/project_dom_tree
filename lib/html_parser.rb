
Tag = Struct.new(:type, :name, :id, :classes, :src,:title )
class HTMLParser

  def initialize(str)
    @html_tag = str
    # create_struct
  end

  def create_struct
    tag = Tag.new(
      type_parse,parse_for(name),parse(id),parse_for(classes),
      parse_for(src), parse_for(title))
  end

  def type_parse
    type = /<(.*?)\s/.match(@html_tag)
    type[1..-1].join("")
  end

  def parse_for(attribute)
    attr_and_value = /#{attribute}\s*=\s*'\s*(.*?)\s*'/.match(@html_tag)
  end
# takes in string
# spits out object that represents tag & can be inquired of to get attributes (id, class, etc)
  # get stuff inside brackets
  # tag name = btwn < & " "
  # attribute name is " " to = (strip)
  # attribute content is = to " " (strip)
  # store 'em all in Struct

end

tag = HTMLParser.new("<p class='foo bar' id='baz' name='fozzie'>")
tag.parse_for("class")