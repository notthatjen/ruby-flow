RSpec.describe RubyFlow::Graph do
  let(:node1) { RubyFlow::Node.new(id: "node-1", data: { label: "Node 1" }) }
  let(:node2) { RubyFlow::Node.new(id: "node-2", data: { label: "Node 2" }) }
  let(:edge) do
    RubyFlow::Edge.new(
      id: "edge-1",
      source: "node-1",
      target: "node-2",
      data: { label: "Edge 1" }
    )
  end
  
  subject(:graph) { described_class.new }

  describe "#initialize", :core do
    it "creates an empty graph" do
      expect(graph.nodes).to be_empty
      expect(graph.edges).to be_empty
    end
  end

  describe "#add_node", :modification do
    it "adds a node to the graph" do
      graph.add_node(node1)
      expect(graph.nodes).to include("node-1" => node1)
    end
  end

  describe "#remove_node", :modification do
    before do
      graph.add_node(node1)
      graph.add_node(node2)
      graph.add_edge(edge)
    end

    it "removes the node and its connected edges" do
      graph.remove_node("node-1")
      expect(graph.nodes).not_to include("node-1" => node1)
      expect(graph.edges).to be_empty
    end
  end

  describe "#add_edge", :modification do
    it "adds an edge to the graph" do
      graph.add_edge(edge)
      expect(graph.edges).to include("edge-1" => edge)
    end
  end

  describe "#remove_edge", :modification do
    before do
      graph.add_edge(edge)
    end

    it "removes the edge from the graph" do
      graph.remove_edge("edge-1")
      expect(graph.edges).to be_empty
    end
  end

  describe "#get_node", :query do
    before do
      graph.add_node(node1)
    end

    it "returns the node with the given id" do
      expect(graph.get_node("node-1")).to eq(node1)
    end
  end

  describe "#get_edge", :query do
    before do
      graph.add_edge(edge)
    end

    it "returns the edge with the given id" do
      expect(graph.get_edge("edge-1")).to eq(edge)
    end
  end

  describe "#get_connected_edges", :query do
    before do
      graph.add_edge(edge)
    end

    it "returns edges connected to the given node" do
      expect(graph.get_connected_edges("node-1")).to contain_exactly(edge)
      expect(graph.get_connected_edges("node-2")).to contain_exactly(edge)
    end
  end

  describe "#to_h", :serialization do
    before do
      graph.add_node(node1)
      graph.add_node(node2)
      graph.add_edge(edge)
    end

    it "returns a hash representation of the graph" do
      hash = graph.to_h
      expect(hash[:nodes]).to contain_exactly(node1.to_h, node2.to_h)
      expect(hash[:edges]).to contain_exactly(edge.to_h)
    end
  end
end 