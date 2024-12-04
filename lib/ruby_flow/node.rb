module RubyFlow
  class Node
    attr_accessor :id, :position, :data, :type, :style
    attr_reader :source_handles, :target_handles

    def initialize(id:, position: { x: 0, y: 0 }, data: {}, type: "default", style: {})
      @id = id
      @position = position
      @data = data
      @type = type
      @style = style
      @source_handles = []
      @target_handles = []
    end

    def add_source_handle(id:, position: "bottom")
      @source_handles << { id: id, position: position }
    end

    def add_target_handle(id:, position: "top")
      @target_handles << { id: id, position: position }
    end

    def to_h
      {
        id: @id,
        position: @position,
        data: @data,
        type: @type,
        style: @style,
        sourceHandles: @source_handles,
        targetHandles: @target_handles
      }
    end
  end
end 