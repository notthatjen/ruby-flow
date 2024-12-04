module FlowHelper
  def ruby_flow_render(graph)
    <<-HTML
      <svg id="flow-container">
        <defs>
          <pattern id="grid" width="20" height="20" patternUnits="userSpaceOnUse">
            <circle cx="1" cy="1" r="1" fill="#CCCCCC"/>
          </pattern>
          <marker id="arrowhead" markerWidth="10" markerHeight="7" 
            refX="9" refY="3.5" orient="auto">
            <polygon points="0 0, 10 3.5, 0 7" fill="#555"/>
          </marker>
        </defs>
        <rect width="100%" height="100%" fill="url(#grid)" pointer-events="none"/>
        <g id="edges"></g>
        <g id="nodes"></g>
      </svg>
      
      <div class="controls">
        <button onclick="zoomIn()">+</button>
        <button onclick="zoomOut()">-</button>
        <button onclick="resetView()">Reset</button>
      </div>

      <script>
        // Initialize the graph data directly from Ruby
        const graphData = #{graph.to_h.to_json};
        window.nodes = graphData.nodes;
        window.edges = graphData.edges;
      </script>
    HTML
  end
end 