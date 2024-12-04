module RubyFlow
  class Graph
    attr_reader :nodes, :edges

    def initialize
      @nodes = {}
      @edges = {}
    end

    def add_node(node)
      @nodes[node.id] = node
    end

    def remove_node(node_id)
      @nodes.delete(node_id)
      @edges.delete_if { |_, edge| edge.source == node_id || edge.target == node_id }
    end

    def add_edge(edge)
      @edges[edge.id] = edge
    end

    def remove_edge(edge_id)
      @edges.delete(edge_id)
    end

    def get_node(node_id)
      @nodes[node_id]
    end

    def get_edge(edge_id)
      @edges[edge_id]
    end

    def get_connected_edges(node_id)
      @edges.values.select { |edge| edge.source == node_id || edge.target == node_id }
    end

    def to_h
      {
        nodes: @nodes.values.map(&:to_h),
        edges: @edges.values.map(&:to_h)
      }
    end
  end
end 