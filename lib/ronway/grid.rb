module Ronway
  class Grid
    attr_reader :size

    def initialize(size, state: nil)
      @size = size
      if state
        raise BadIntialState unless size_equals_state?(size, state)
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

    def get_neighbors_from_index(index)
      cell_neighbords = []

      #above
      cell_neighbords << @storage[index + size] unless index < size
      #below
      cell_neighbords << @storage[index - size] unless last_row?(index)
      #left
      cell_neighbords << @storage[index - 1] unless index % size == 0
      #right
      unless (index + 1) % size == 0
        cell_neighbords << @storage[index + 1]
      end

      p cell_neighbords

      #cell_neighbords.map { |i| @storage[i] }
    end

    private
    def number_of_cells(size)
      size * size
    end

    def size_equals_state?(size, state)
      number_of_cells(size) == state.length
    end

    def last_row?(index)
      index >= number_of_cells(size) - size
    end

  end
end
