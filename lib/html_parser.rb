Node = Struct.new(:tag, :parent, :children, :data)

class HTMLParser

  def initialize(html_doc)
    @page_array = File.open(html_doc).readlines
  end

  def parse_page(match_data = @page_array)
    crawl_page_array
  end

  def crawl_page_array
    i = 0
    until @page_array.empty?
      stack_of_parents = []
      tag = scan_for_tag(@page_array[i])
      if !!tag
        if is_end_tag?(tag)
          stack_of_parents.pop
        else
          node = TagGenerator.new(tag)
          node.parent = stack_of_parents[-1]
          node.parent.childern << node if node.parent
          stack_of_parents << node
        end
        @page_array.shift
      else
        node = Node.new(@page_array[i],stack_of_parents[-1])
      end
    end
  end

  def is_end_tag?(tag)
    end_tag_scan_regex = /<\/(.*?)/
    !!tag.match(tag_scan_regex)
  end

  def scan_for_tag(input)
    tag_scan_regex = /<(.*?)>/m
    data = input.match(tag_scan_regex)
    data[0][1..-2] unless data.nil?
  end

  def build_tree(tag, current_data)
    node = Node.new(tag, nil, nil, current_data)

  end

end

HTMLParser.new("html_easy.html").scan_for_tag("sahkjdahildhal")