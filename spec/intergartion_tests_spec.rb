require "main"

describe "DomParser" do 
  let(:p_node) {Node.new(Tag.new("p"),nil,[])}
  let(:text_node) {Node.new("text",p_node,[],"this is an example")}
  let(:div_node)  {Node.new(Tag.new("div", "larry","some_div", ["foo","bar"]),p_node,[])}
  let(:other_text) {Node.new("text", div_node,[],"another example")}
  let(:insertable_node) {Node.new("text", div_node,[],"this node was inserted")}
  let(:tree_head) do 
    p_node.children << div_node
    p_node.children << text_node
    div_node.children << other_text
  end  
  let(:searcher) {TreeSearcher.new(p_node)}
  let(:insert_delete) {InsertDelete.new(p_node)}

  describe "#html_parser" do
    it "opens a given file without throwing an error" do 
      expect{ HTMLParser.new("test.html")}.to_not raise_error
    end

    it "throws an error if there is no such file" do
      expect{ HTMLParser.new("the_fake_File.html")}.to raise_error(Errno::ENOENT)
    end

    it "has a root node" do 
      x = HTMLParser.new("test.html")
      expect(x.root).to be_a(Node)
    end
  end
 
  describe "searcher" do 
    it "can find text nodes with matching text" do
      tree_head
      expect(searcher.search("text","this" ,p_node)).to eq([text_node])    
    end

    it "can find multiple text nodes" do
      tree_head
      expect(searcher.search("text","example" ,p_node)).to eq([text_node,other_text]) 
    end

    it "it returns an empty array if the search fails"  do
      tree_head
      expect(searcher.search("text","thisisicomeo",p_node)).to eq([])
    end

    it "can search for specific properties, such as class" do
      tree_head
      expect(searcher.search("type","div", p_node)).to eq([div_node])
    end

    it "if given a bad term, throws an error" do
      tree_head
      expect{searcher.search("green","type",p_node)}.to raise_error(RuntimeError)
    end

    it "it doesn't get confused by a node with several classes" do
      tree_head
      expect(searcher.search("class","bar", p_node)).to eq([div_node])
    end
 
    it "can be asked to do an ancestor search" do
      tree_head
      expect(searcher.search_ancestors("type","p", div_node)).to eq([p_node])
    end

    it "returns an empty array if the ancestor search fails" do 
      tree_head
      expect(searcher.search_ancestors("type","div", div_node)).to eq([])
    end
  end  

  describe "insertdelete" do
    it "can add nodes to the bottom of an existing tree" do
      tree_head 
      insert_delete.insert_node_below(p_node,insertable_node)
      expect(insert_delete.head.children).to include(insertable_node)
    end

    it "can remove nodes at the bottom of the tree" do  
      tree_head
      insert_delete.delete_node(text_node)
      expect(insert_delete.head.children).to_not include(text_node)
    end 
 
    it "can remove nodes in the middle of the tree" do
      tree_head
      insert_delete.delete_node(div_node)
      expect(insert_delete.head.children).to_not include(div_node)
    end

    it "adds its children to the father node when added to the middle of a tree" do 
      tree_head
      insert_delete.delete_node(div_node)
      expect(insert_delete.head.children).to include(other_text)
    end

    it "throws an error if you try to remove a root with multiple children" do
      tree_head
      expect{insert_delete.delete_node(p_node)}.to raise_error(RuntimeError)
    end

    it "can insert nodes at a given node"
  end
end