class TreeSearcher
  def initialize(root)
    @root = root
  end

  #write a search function that finds all terms matching the category
  def search(category, term, origin_node = @root)
    raise "#{category} is not a valid category" unless valid?(category.downcase.strip)
    if category == "text"
      return text_search(term, origin_node)
    else
      # return other_search(category,term, origin_node)
    end
  end

  def valid?(category)
    category == "id" || category == "name" || 
    category == "text" ||  category == "class" 
  end

  def text_search(term, node)
    #gonna implement a BFS for giggles
    queue = []
    matching_nodes_array = []
    node.children.each {|child| queue << child}
    until queue.empty?
      node = queue.unshift
      if node.tag == "text" #????
        matching_nodes_array << node if matches?(term, node.data) 
      end
      if !!current_node.children
         current_node.children.each {|child| queue << child}
      end
    end
  end

  def matches?(term,string)
    result = /#{term}/m.match(string)
    !!result
  end

end

