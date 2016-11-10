require_relative "tag_generator"

class HTMLParser

  def initialize(html_doc)
    @page = File.open(html_doc).readlines
    @page = @page.join("")
  end

  def parse_page(match_data = @page)
    tag = scan_for_tag
    grab_everything = /(?<=#{tag}\>)(\s*.*\s*)(?=\<\/#{tag}\>)/m 
    grab_everything.match(match_data)
    parse_page()
    #add the text in, nodes for every parse down
  end

  def scan_for_tag
    tag_scan_regex = /<(.*?)>/m
    data = @page.match(tag_scan_regex)
    data[0][1..-2]
  end

end

HTMLParser.new("html_easy.html").parse_page