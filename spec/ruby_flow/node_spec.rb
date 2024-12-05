RSpec.describe RubyFlow::Node do
  let(:node_id) { "node-1" }
  let(:position) { { x: 100, y: 200 } }
  let(:data) { { label: "Test Node" } }
  
  subject(:node) { described_class.new(id: node_id, position: position, data: data) }

  describe "#initialize", :core do
    it "creates a node with the given attributes" do
      expect(node.id).to eq(node_id)
      expect(node.position).to eq(position)
      expect(node.data).to eq(data)
      expect(node.type).to eq("default")
      expect(node.style).to eq({})
    end

    it "initializes empty source and target handles" do
      expect(node.source_handles).to be_empty
      expect(node.target_handles).to be_empty
    end
  end

  describe "#add_source_handle", :handles do
    it "adds a source handle with the given id and position", :modification do
      node.add_source_handle(id: "handle-1")
      expect(node.source_handles).to contain_exactly(
        { id: "handle-1", position: "bottom" }
      )
    end
  end

  describe "#add_target_handle", :handles do
    it "adds a target handle with the given id and position", :modification do
      node.add_target_handle(id: "handle-1")
      expect(node.target_handles).to contain_exactly(
        { id: "handle-1", position: "top" }
      )
    end
  end

  describe "#to_h", :serialization do
    it "returns a hash representation of the node" do
      hash = node.to_h
      expect(hash).to include(
        id: node_id,
        position: position,
        data: data,
        type: "default",
        style: {},
        source_handles: [],
        target_handles: []
      )
    end
  end
end 