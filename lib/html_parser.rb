
Tag = Struct.new(:type, :name, :id, :classes, :src,:title )
class HTMLParser

  def initialize(str)
    @html_tag = str
    # create_struct
  end

  def create_struct
    tag = Tag.new(
      type_parse,parse_for("name"),parse_for("id"),parse_for("class"),
      parse_for("src"), parse_for("title"))
  end

  def type_parse
    type = /<(.*?)\s/.match(@html_tag)
    type[1..-1].join("")
  end

  def parse_for(attribute)
    attr_and_value = /#{attribute}\s*=\s*'\s*(.*?)\s*['"]/.match(@html_tag)
    return nil if attr_and_value.nil?
    value = attr_and_value[1..-1]  
    return value[0].split(" ") if !!value[0].match(/\s/)
    return value[0]
  end
end

tag = HTMLParser.new("<p class='foo bar' id='baz'>")
p tag.create_struct