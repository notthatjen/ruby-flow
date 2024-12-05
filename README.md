<p align="center">
  <img src="https://raw.githubusercontent.com/notthatjen/ruby-flow/main/demo/public/images/ruby-flow-icon.svg" width="128" height="128" alt="Ruby Flow Logo">
</p>

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

# Create nodes with handles
node1 = RubyFlow::Node.new(
  id: '1',
  position: { x: 100, y: 100 },
  data: { label: 'Node 1' }
)
# Add source handles to node1
node1.add_source_handle(id: 'n1-right', position: 'right')
node1.add_source_handle(id: 'n1-bottom', position: 'bottom')

node2 = RubyFlow::Node.new(
  id: '2',
  position: { x: 300, y: 100 },
  data: { label: 'Node 2' }
)
# Add target handles to node2
node2.add_target_handle(id: 'n2-left', position: 'left')
node2.add_target_handle(id: 'n2-top', position: 'top')

# Add nodes to the graph
graph.add_node(node1)
graph.add_node(node2)

# Create an edge between specific handles
edge = RubyFlow::Edge.new(
  id: 'e1-2',
  source: '1',
  target: '2',
  source_handle: 'n1-right',
  target_handle: 'n2-left'
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

The demo shows an interactive graph visualization with draggable nodes and connection handles.

## Features

- Create and manage nodes with customizable properties
- Connect nodes with edges
- Advanced handle system:
  - Multiple handles per node side (automatically distributed)
  - Source and target handle types
  - Support for all positions (top, right, bottom, left)
  - Visual feedback on hover
- Interactive UI:
  - Draggable nodes
  - Infinite panning canvas
  - Zoom controls
  - Dotted grid background
- Flexible node and edge styling
- Graph management and traversal
- Easy integration with web frameworks (Rails/Sinatra)
- Development mode with auto-reloading (Sinatra)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

For development with auto-reloading in the demo app:

1. Make sure you have the required dependencies:

```bash
$ bundle add sinatra-contrib
```

2. The demo app is configured to auto-reload changes in:
   - `demo/app.rb`
   - Files in `lib/**/*.rb`
   - Files in `demo/helpers/**/*.rb`

3. Just refresh your browser to see code changes without restarting the server

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/notthatjen/ruby-flow.

This project uses [Auto-it](https://github.com/intuit/auto) to automate releases and manage contributions. When creating pull requests, please:

1. Use [Conventional Commits](https://www.conventionalcommits.org/) format for your commit messages
2. Your PR will be automatically labeled based on the commit type:
   - `fix:` for bug fixes (patch release)
   - `feat:` for new features (minor release)
   - `feat!:` or `fix!:` for breaking changes (major release)
   - `docs:` for documentation changes
   - `chore:` for maintenance tasks

3. The release process will automatically:
   - Update the CHANGELOG
   - Create a new release
   - Publish to RubyGems
   - Create GitHub releases

### Development Process

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes using conventional commits:
   ```bash
   git commit -m "feat: add amazing feature"
   # or
   git commit -m "fix: resolve issue with X"
   ```
4. Push to your branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

The gem is available as open source under the terms of the MIT License. 