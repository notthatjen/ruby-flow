module RubyFlow
  class Edge
    attr_accessor :id, :source, :target, :source_handle, :target_handle, :type, :style, :data

    def initialize(id:, source:, target:, source_handle:, target_handle:, type: "default", style: {}, data: {})
      @id = id
      @source = source
      @target = target
      @source_handle = source_handle
      @target_handle = target_handle
      @type = type
      @style = style
      @data = data
    end

    def to_h
      {
        id: @id,
        source: @source,
        target: @target,
        source_handle: @source_handle,
        target_handle: @target_handle,
        type: @type,
        style: @style,
        data: @data
      }
    end
  end
end 