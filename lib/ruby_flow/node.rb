module RubyFlow
  class Handle
    VALID_POSITIONS = %w[bottom top right left]
    attr_reader :id, :position, :type

    def initialize(id:, position: "bottom", type: "source")
      unless VALID_POSITIONS.include?(position)
        raise ArgumentError, "Invalid position: #{position}. Must be one of: #{VALID_POSITIONS.join(', ')}"
      end
      
      @id = id
      @position = position
      @type = type
    end

    def to_h
      {
        id: @id,
        position: @position,
        type: @type
      }
    end
  end

  class Node
    attr_accessor :id, :position, :data, :type, :style
    attr_reader :handles

    def initialize(id:, position: { x: 0, y: 0 }, data: {}, type: "default", style: {})
      @id = id
      @position = position
      @data = data
      @type = type
      @style = style
      @handles = []
    end

    def add_handle(id:, position: "bottom", type: "source")
      handle = Handle.new(id: id, position: position, type: type)
      @handles << handle
      handle
    end

    def add_source_handle(id:, position: "bottom")
      add_handle(id: id, position: position, type: "source")
    end

    def add_target_handle(id:, position: "top")
      add_handle(id: id, position: position, type: "target")
    end

    def source_handles
      @handles.select { |h| h.type == "source" }.map(&:to_h)
    end

    def target_handles
      @handles.select { |h| h.type == "target" }.map(&:to_h)
    end

    def to_h
      {
        id: @id,
        position: @position,
        data: @data,
        type: @type,
        style: @style,
        source_handles: source_handles,
        target_handles: target_handles
      }
    end
  end
end 