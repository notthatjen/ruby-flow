require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader' if development?
require 'ruby_flow'
require_relative 'helpers/flow_helper'

class RubyFlowApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload './lib/**/*.rb'
    also_reload './demo/helpers/**/*.rb'
    enable :reloader
  end

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
    # Add handles to node1
    node1.add_source_handle(id: 'n1-right', position: 'right')
    node1.add_source_handle(id: 'n1-bottom', position: 'bottom')

    node2 = RubyFlow::Node.new(
      id: '2',
      position: { x: 300, y: 100 },
      data: { label: 'Node 2' }
    )
    # Add handles to node2
    node2.add_target_handle(id: 'n2-left', position: 'left')
    node2.add_target_handle(id: 'n2-top', position: 'top')

    # Create node3 with multiple handles
    node3 = RubyFlow::Node.new(
      id: '3',
      position: { x: 200, y: 250 },
      data: { label: 'Node 3' }
    )
    # Add handles to node3 (both source and target)
    node3.add_source_handle(id: 'n3-right', position: 'right')
    node3.add_target_handle(id: 'n3-left', position: 'left')
    node3.add_source_handle(id: 'n3-bottom1', position: 'bottom')
    node3.add_target_handle(id: 'n3-bottom2', position: 'bottom')
    node3.add_target_handle(id: 'n3-top', position: 'top')

    # Add nodes to the graph
    graph.add_node(node1)
    graph.add_node(node2)
    graph.add_node(node3)

    # Create edges between nodes using specific handles
    edge1 = RubyFlow::Edge.new(
      id: 'e1-2',
      source: '1',
      target: '2',
      source_handle: 'n1-right',
      target_handle: 'n2-left'
    )

    edge2 = RubyFlow::Edge.new(
      id: 'e1-3',
      source: '1',
      target: '3',
      source_handle: 'n1-bottom',
      target_handle: 'n3-top'
    )

    # Add edges to the graph
    graph.add_edge(edge1)
    graph.add_edge(edge2)
    graph
  end

  # Serve the main page
  get '/' do
    @graph = create_sample_graph
    erb :index
  end

  set :public_folder, File.dirname(__FILE__) + '/public'
end 