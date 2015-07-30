module Ronway
  class Grid
    attr_reader :size

    def initialize(size, state: nil)
      @size = size
      if state
        @storage = state.map{ |status| Cell.new(status)}
      else
        @storage = number_of_cells(@size).times.map { Cell.new }
      end

    end

    def state
      @storage.map(&:status)
    end

    def[](x,y)
      @storage[x + (y * size)]
    end

    private
    def number_of_cells(size)
      size * size
    end

  end
end
