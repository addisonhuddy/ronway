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
      expect(grid.get_neighbors_from_index(4).size).to eq 4
    end

    it "find the number of neighbors for top row cells" do
      expect(grid.get_neighbors_from_index(1).size).to eq 3
    end

    it "find the number of neighbors for bottom row cells" do
      expect(grid.get_neighbors_from_index(7).size).to eq 3
    end

    it "find the number of neighbors for far left column" do
      expect(grid.get_neighbors_from_index(0).size).to eq 2
    end

    it "find the number of neighbors for the far right column" do
      expect(grid.get_neighbors_from_index(2).size).to eq 2
    end

  end

end
