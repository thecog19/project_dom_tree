
Tag = Struct.new(:type, :name, :id, :classes, :src,:title )
class HTMLParser

  def initialize(str)
    @html_tag = str
  end

  def create_struct
    tag = Tag.new(
      type_parse,parse_for(name),parse(id),parse_for(classes),
      parse_for(src), parse_for(title))
  end

  def type_parse

  end
# takes in string
# spits out object that represents tag & can be inquired of to get attributes (id, class, etc)
  # get stuff inside brackets
  # tag name = btwn < & " "
  # attribute name is " " to = (strip)
  # attribute content is = to " " (strip)
  # store 'em all in Struct

end