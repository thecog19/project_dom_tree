class InsertDelete
  attr_accessor :head
  def initialize(head)
    @head = head
  end

  def delete_node(node)
    if node == @head
      raise "Cannot delete a head with multiple children" if node.children[1]
      node.children[0].parent = nil
      @head = node.children[0]
      @head
    elsif node.children == []
      target_index = node.parent.children.index(node)
      node.parent.children.delete_at(target_index) 
      node.parent = nil
    else
      node.children.each do |child|
        child.parent = node.parent
        node.parent.children << child
      end
      #should be a callable method
      target_index = node.parent.children.index(node)
      node.parent.children.delete_at(target_index) 
      ##################
      node.parent = nil
    end
  end

  def insert_node_below(target_node, new_node)
    new_node.parent = target_node
    target_node.children << new_node
  end

  def insert_node_between(target_node,new_node,child_node = nil)
    if child_node = nil
      insert_node_below(target_node, new_node)
    else
      raise "No such child node" unless target_node.children.include?(child_node)
      new_node.parent = target_node
      target_index = target_node.children.index(child_node)
      target_node.children[target_index] = new_node
      child_node.parent = new_node
      new_node.children << child_node
    end
  end
end

