class Renderer
  def initialize(root)
    @root = root
  end

  def display
    puts "<!doctype html>"
    stack = []
    @root.children.each {|child| stack << child}
    until stack.empty?
      current_node = stack.pop
      if current_node.is_a?(String)
        puts "#{current_node} \n"
      elsif current_node.tag == "text"
        puts "#{current_node.data} \n" 
      else
        stack << "</#{current_node.tag.type}>" unless VOID_ELEMENTS.include?(
                                              current_node.tag.type)
        current_node.children.each {|child| stack << child}  
        string = generate_string(current_node.tag) 
        puts string
      end
    end
  end

  def render(node = @root)
    data = node_data(node)
    puts "There are #{data[0]} nodes in the tree \n \n"

    #here we turn the type_array into a hash
    type_hash = Hash.new(0)
    data[1].each { |type| type_hash[type] += 1 }
    puts "These are the tags contained in the tree:"
    type_hash.each do |type, number|
      puts "%-8s: %s" % ["#{type}", "#{number}"]
    end

    puts "\nThe given root had the following properties"
    node.each_pair do |attribute, value|

      if attribute == :tag && value.is_a?(Struct)
        value.each_pair do |html, thing|
          if thing
            puts "#{html} => #{thing}"
          end
        end
      elsif value
        if attribute == :children
        elsif attribute == :parent
          puts "parent => #{value.tag}"
        else
          puts "#{attribute} => #{value}" 
        end
      else 
        puts "#{attribute} => none"
      end
    end
    unless node.children.empty?
      puts "\nAll children tags"
        node.children.each do |child|
          if child
            puts child.tag.type unless child.tag.is_a?(String) 
            puts child.tag if child.tag.is_a?(String)
          end
        end 
    end
    data
  end


  def node_data(node)
    node_count = 0
    type_array = []
    stack = []
    node.children.each {|child| stack << child}
    until stack.empty?
      current_node = stack.pop
      unless current_node == node
        node_count += 1
        type_array << current_node.tag.type unless current_node.tag == "text"
        type_array << current_node.tag if current_node.tag == "text"
      end  
      if !!current_node.children
         current_node.children.each {|child| stack << child}
      end
    end
    return node_count, type_array
  end

  def generate_string(tag)
    return "<#{tag.type}> \n" unless !!tag.id || !!tag.classes
    return "<#{tag.type} id = '#{tag.id}'> \n" unless tag.classes
    if tag.classes.is_a?(Array)
      tag.classes = tag.classes.join(" ")
    end
    return "<#{tag.type} class = '#{tag.classes}'> \n" unless tag.id
    return "<#{tag.type} class = '#{tag.classes}' id = '#{tag.id}'> \n"
  end
end