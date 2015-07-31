require 'spec_helper'

describe Ronway::Grid do
  let(:grid) { Ronway::Grid.new(3) }

  it "accepts a size argument and generates a square gride" do
    expect(grid.state.length).to eq 9
  end

  it "create a grid of unique cells" do
    expect(grid[0, 0].object_id).not_to eq(grid[0, 1].object_id)
  end

  it "can retrive cells for the grid" do
    grid = Ronway::Grid.new(2, state: [:dead, :alive, :dead, :alive])
    expect(grid[1, 1].alive?).to be true
  end

  context "specifying an initial grid state" do
    it "can accept an initial grid state" do
      grid = Ronway::Grid.new(2, state: [:dead, :dead, :alive, :dead])
      expect(grid[0, 0].dead?).to be true
      expect(grid[0, 1].dead?).to be false
    end

    it "raises an exception when size and state aren't equal" do
      expect {
        Ronway::Grid.new(2, state: [:dead])
      }.to raise_error(Ronway::BadIntialState)

      expect {
        Ronway::Grid.new(4, state: [:dead, :alive, :dead, :alive, :dead, :alive])
      }.to raise_error(Ronway::BadIntialState)
    end
  end

  context "finding cell neighbors" do
    it "finds the number of neighbors for a cell in the middle of the grid" do
      expect(grid.get_neighbors_from_index(4).size).to eq 8
    end

    it "find the number of neighbors for top row cells" do
      expect(grid.get_neighbors_from_index(1).size).to eq 5
    end

    it "find the number of neighbors for bottom row cells" do
      expect(grid.get_neighbors_from_index(7).size).to eq 5
    end

    it "find the number of neighbors for far left column" do
      expect(grid.get_neighbors_from_index(0).size).to eq 3
    end

    it "find the number of neighbors for the far right column" do
      expect(grid.get_neighbors_from_index(2).size).to eq 3
    end
  end

  context "print the grid" do
    it "can print the grid to the screen" do
      grid = Ronway::Grid.new(2, state: [:dead, :alive,
                                         :dead, :alive])
      expected_grid = " o\n o\n"

      expect(grid.to_s).to eq expected_grid
    end
  end

  context "rule 1: a sole cell dies" do
    it "kills any living sole cell" do
      grid = Ronway::Grid.new(2, state: [:dead, :alive,
                                         :dead, :dead])
      grid.generate!

      expect(grid.state).to eq [:dead, :dead,
                                :dead, :dead]
    end
  end

  context "rule 2: any live cell with 2 or 3 live neighbors lives" do
    it "cell lives with two neighbors" do
      grid = Ronway::Grid.new(2, state: [:alive, :alive,
                                         :alive, :alive])
      grid.generate!

      expect(grid.state).to eq [:alive, :alive,
                                :alive, :alive]
    end
  end

  context "rule 3: any cell with more than 3 live neighbors dies due to over-popultion" do
    it "kills cells with too many neighbors" do
      grid = Ronway::Grid.new(3, state: [:alive, :alive, :alive,
                                         :alive, :alive, :alive,
                                         :dead, :dead, :dead])
      grid.generate!

      expect(grid.state).to eq [:alive, :dead, :alive,
                                :alive, :dead, :alive,
                                :dead, :alive, :dead]
    end
  end

  context "rule 4: dead cells with 3 live neighbors come to life" do
    it "brings cells to life that have exactly 3 live neighbors" do
      grid = Ronway::Grid.new(3, state: [:dead, :alive, :dead,
                                         :alive,:dead, :alive,
                                         :dead, :dead, :dead])
      grid.generate!

      expect(grid.state).to eq [:dead, :alive, :dead,
                                :dead, :alive, :dead,
                                :dead, :dead, :dead]
    end
  end
end
