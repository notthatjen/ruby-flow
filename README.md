# RubyFlow

RubyFlow is a Ruby library for building node-based editors, workflows, and interactive diagrams. It's inspired by [React Flow](https://reactflow.dev/) and provides similar functionality for Ruby applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-flow'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install ruby-flow
```

## Usage

Here's a basic example of how to use RubyFlow:

```ruby
require 'ruby_flow'

# Create a new graph
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

# Get the graph data as a hash
graph_data = graph.to_h
```

## Demo

To run the demo application:

1. Clone the repository
2. Install dependencies:

```bash
$ bundle install
```

3. Run the demo server:

```bash
$ cd demo
$ bundle exec rackup
```

4. Open your browser and visit `http://localhost:9292`

The demo shows a simple graph visualization using React Flow's web components.

## Features

- Create and manage nodes with customizable properties
- Connect nodes with edges
- Support for source and target handles
- Flexible node and edge styling
- Graph management and traversal
- Easy integration with web frameworks (Rails/Sinatra)
- Visual representation using React Flow

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/notthatjen/ruby-flow.

## License

The gem is available as open source under the terms of the MIT License. 