RSpec.describe RubyFlow::Edge do
  let(:edge_id) { "edge-1" }
  let(:source) { "node-1" }
  let(:target) { "node-2" }
  let(:source_handle) { "handle-1" }
  let(:target_handle) { "handle-2" }
  let(:data) { { label: "Test Edge" } }
  
  subject(:edge) do
    described_class.new(
      id: edge_id,
      source: source,
      target: target,
      source_handle: source_handle,
      target_handle: target_handle,
      data: data
    )
  end

  describe "#initialize", :core do
    it "creates an edge with the given attributes" do
      expect(edge.id).to eq(edge_id)
      expect(edge.source).to eq(source)
      expect(edge.target).to eq(target)
      expect(edge.source_handle).to eq(source_handle)
      expect(edge.target_handle).to eq(target_handle)
      expect(edge.type).to eq("default")
      expect(edge.style).to eq({})
      expect(edge.data).to eq(data)
    end
  end

  describe "#to_h", :serialization do
    it "returns a hash representation of the edge" do
      hash = edge.to_h
      expect(hash).to include(
        id: edge_id,
        source: source,
        target: target,
        sourceHandle: source_handle,
        targetHandle: target_handle,
        type: "default",
        style: {},
        data: data
      )
    end
  end
end 