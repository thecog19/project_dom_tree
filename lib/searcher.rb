class TreeSearcher
  #holds some lambdas!
  COMMANDS = {
    "id" => ->(node) {node.tag.id},
    "name" => ->(node) {node.tag.name},
    "class" => ->(node) {node.tag.classes},
    "classes" => ->(node) {node.tag.classes},
    "type" => ->(node) {node.tag.type},
    "tag" => ->(node) {node.tag.type}
  }  

  def initialize(root)
    @root = root
  end


  #write a search function that finds all terms matching the category
  def search(category, term, origin_node = @root)
    raise "#{category} is not a valid category" unless valid?(category.downcase.strip)
    if category == "text"
      return text_search(term, origin_node)
    else
      return other_search(category,term, origin_node)
    end
  end

  def valid?(category)
    category == "id" || category == "name" || 
    category == "text" ||  category == "class" ||
    category == "type" || category == "tag"
  end

  def text_search(term, node)
    #gonna implement a BFS for giggles
    queue = []
    matching_nodes_array = []
    node.children.each {|child| queue << child}
    until queue.empty?
      node = queue.shift
      if node.tag == "text"
        matching_nodes_array << node if matches_text?(term, node.data) 
      end
      if node.children
         node.children.each {|child| queue << child}
      end
    end
  matching_nodes_array
  end

  def other_search(category, term, node)
    queue = []
    matching_nodes_array = []
    node.children.each {|child| queue << child}
    until queue.empty?
      node = queue.shift
      if node.tag != "text"
        matching_nodes_array << node if matches_tag?(category,term,node)
      end
      if node.children
         node.children.each {|child| queue << child}
      end
    end
  matching_nodes_array
  end

  def search_ancestors(category,term,node = @root)
    #we're gonna use a stack here. Cause we can. 
    stack = []
    matching_nodes_array = []
    stack << node.parent if !!node.parent
    until stack.empty?
      node = stack.pop
      matching_nodes_array << node if matches_tag?(category,term,node)
      stack << node.parent if node.parent
    end
    matching_nodes_array
  end

  def matches_tag?(category,term, node)
    content = COMMANDS[category].call(node)
    if content.is_a?(Array)
      return true if content.any? do |html_class| 
        x = /#{html_class}/.match(term)
        !!x
      end
    end
    x =  /#{term}/.match(content)
    !!x
  end

  def matches_text?(term,string)
    result = /#{term}/m.match(string)
    !!result
  end

end
