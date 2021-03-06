Tag = Struct.new( :type,:name, :id, :classes, :src, :title, )
# Make regexs CONSTANTS
class TagGenerator

  def initialize(str)
    @html_tag = str
  end

  def create_struct(str = @html_tag)
    tag = Tag.new(
      type_parse,parse_for("name"),parse_for("id"),parse_for("class"),
      parse_for("src"), parse_for("title"))
  end

  def type_parse
    type = /<(.*?)\s/.match(@html_tag)
    return type[1..-1].join("") if type
    type = /<(.*?)>/.match(@html_tag)
    return type[1..-1].join("") if type
    nil
  end

  def parse_for(attribute)
    attr_and_value = /#{attribute}\s*=\s*"\s*(.*?)\s*"/.match(@html_tag)
    return nil if attr_and_value.nil?
    value = attr_and_value[1..-1]  
    return value[0].split(" ") if !!value[0].match(/\s/)
    return value[0]
  end
end