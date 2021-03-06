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

      #check left and right
      cell_neighbords << @storage[index - 1] unless far_left?(index)
      cell_neighbords << @storage[index + 1] unless far_right?(index)

      #first row
      unless top_row?(index)
        cell_neighbords << @storage[above(index) - 1] unless far_left?(index)
        cell_neighbords << @storage[above(index) + 1] unless far_right?(index)
        cell_neighbords << @storage[above(index)]
      end

      #last row
      unless last_row?(index)
        cell_neighbords << @storage[below(index) - 1] unless far_left?(index)
        cell_neighbords << @storage[below(index) + 1] unless far_right?(index)
        cell_neighbords << @storage[below(index)]
      end

      cell_neighbords

    end

    def generate!
      new_generation = []
      @storage.each_with_index do |cell, index|
        neighbors = get_neighbors_from_index(index)
        living_neighbors_count = neighbors.select(&:alive?).count

        if living_neighbors_count < 2 #rule 1
          new_generation[index] = :dead
        elsif cell.alive? && [2, 3].include?(living_neighbors_count) #rule 2
          new_generation[index] = :alive
        elsif cell.alive? && living_neighbors_count > 3 #rule 3
          new_generation[index] = :dead
        elsif cell.dead? && living_neighbors_count == 3 #rule 4
          new_generation[index] = :alive
        end
      end

      new_generation.each_with_index do |status, index|
        if status == :alive
          @storage[index].live!
        else
          @storage[index].die!
        end
      end

    end

    def to_s
      grid_string = ""
      @storage.each_with_index do |cell, index|
        grid_string += "#{cell}"
        grid_string += "\n" if far_right?(index)
      end

      grid_string
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

    def top_row?(index)
      index < size
    end

    def above(index)
      index - size
    end

    def below(index)
      index + size
    end

    def far_right?(index)
      (index + 1) % size == 0
    end

    def far_left?(index)
      index % size == 0
    end

  end
end
