module FlowHelper
  def ruby_flow_render(graph)
    <<-HTML
      <div id="flow-root"></div>
      <script>
        const graphData = #{graph.to_h.to_json};
        window.nodes = graphData.nodes;
        window.edges = graphData.edges;
      </script>
    HTML
  end
end 