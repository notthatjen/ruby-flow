require 'sinatra'
require 'sinatra/json'
require 'ruby_flow'
require_relative 'helpers/flow_helper'

class RubyFlowApp < Sinatra::Base
  helpers FlowHelper

  # Create a sample graph
  def create_sample_graph
    graph = RubyFlow::Graph.new

    # Create nodes
    node1 = RubyFlow::Node.new(
      id: '1',
      position: { x: 100, y: 100 },
      data: { label: 'Node 1' }
    )

    node2 = RubyFlow::Node.new(
      id: '2',
      position: { x: 300, y: 100 },
      data: { label: 'Node 2' }
    )

    # Add nodes to the graph
    graph.add_node(node1)
    graph.add_node(node2)

    # Create an edge between nodes
    edge = RubyFlow::Edge.new(
      id: 'e1-2',
      source: '1',
      target: '2'
    )

    # Add edge to the graph
    graph.add_edge(edge)
    graph
  end

  # Serve the main page
  get '/' do
    @graph = create_sample_graph
    erb :index
  end

  set :public_folder, File.dirname(__FILE__) + '/public'
end 