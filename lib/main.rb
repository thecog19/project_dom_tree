require_relative "writer"
require_relative "tag_generator"
require_relative "renderer"
require_relative "searcher"
require_relative "html_parser.rb"
require_relative "insert_delete"

x = HTMLParser.new("test.html")
y = Renderer.new(x.root)
y.render
z = CreateFile.new(x.root, "output.txt")