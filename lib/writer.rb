class CreateFile

  def initialize(tree, target)
    @root = tree
    @target = target
    write_new
  end

  def write_new(tree = @tree, target = @target)
    File.open("#{target}", 'w') do |file|
      file.write("<!doctype html>")
      stack = []
      @root.children.each {|child| stack << child}
      until stack.empty?
        current_node = stack.pop
        if current_node.is_a?(String)
           file.write("#{current_node} \n")
        elsif current_node.tag == "text"
           file.write("#{current_node.data} \n") 
        else
          stack << "</#{current_node.tag.type}>" unless VOID_ELEMENTS.include?(
                                                          current_node.tag.type)
          current_node.children.each {|child| stack << child}
          string = generate_string(current_node.tag)  
          file.write(string)
        end
      end
    end
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