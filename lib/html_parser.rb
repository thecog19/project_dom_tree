
Node = Struct.new(:tag, :parent, :children, :data)


END_TAG = /<\/.*?>/
FULL_TAG = /<.*?>/
GODHEAD = /(<[\/!]?[\w\s="'-]+>\s*)|([^<>]*)/
VOID_ELEMENTS = "area, base, br, col, command, embed, hr, img, input, keygen, link, meta, param, source, track, wbr".split(', ')

class HTMLParser
  attr_reader :root, :page_array
  def initialize(html_doc)
    @page_array = File.open(html_doc).readlines
    @page_string = @page_array.join
    @page_array = setup_array
    @root = Node.new(html_doc, nil, [], ".html") 
    parse_page
  end

  def setup_array
    list = @page_string.scan(GODHEAD).map! do |entry|
      entry.compact!
      entry[0].strip
    end
    list.delete("<!doctype html>")
    return list

  end

  def parse_page
    current_parent = @root
    until @page_array.empty?
      if is_a_close_tag?(@page_array[0])
        current_parent = current_parent.parent
        @page_array.shift
      elsif is_a_tag?(@page_array[0])
        current_node = Node.new(
          TagGenerator.new(@page_array.shift).create_struct,
          current_parent, [], nil)
        current_parent.children.unshift(current_node)
        current_parent = current_node
      else
        current_node = Node.new("text",  current_parent, [], @page_array.shift)
        current_parent.children.unshift(current_node)
      end
    end
  end

  def is_a_close_tag?(tag)
    !!tag.match(END_TAG)
  end

  def is_a_tag?(tag)
    !!tag.match(FULL_TAG)
  end
end