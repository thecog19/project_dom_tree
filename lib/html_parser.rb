Node = Struct.new(:tag, :parent, :children, :data)

class HTMLParser

  def initialize(html_doc)
    print @page_array = File.open(html_doc).readlines
  end

  def parse_page(match_data = @page_array)
    crawl_page_array



    tag = scan_for_tag
    grab_everything = /(?<=#{tag}\>)(\s*.*\s*)(?=\<\/#{tag}\>)/m 
    current_data = grab_everything.match(match_data)
    parse_page(current_data)
    #add the text in, nodes for every parse down
    build_tree(tag, current_data)
  end

  def crawl_page_array
    i = 0
    until @page_array.empty?
      if @page_array[0]
    end
  end

  def scan_for_tag
    tag_scan_regex = /<(.*?)>/m
    data = @page.match(tag_scan_regex)
    data[0][1..-2]
  end

  def build_tree(tag, current_data)
    node = Node.new(tag, nil, nil, current_data)

  end

end

HTMLParser.new("html_easy.html")