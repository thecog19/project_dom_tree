class HTMLParser

  def initialize(html_doc)
    @page = File.open(html_doc)
  end

  def parse_page

  end

end

# str = "niblets yoyoyoyoy niblets"
# regex = /niblets(.*)niblets/
# our_match = str.match(regex)
# p our_match.captures
# p our_match[1]