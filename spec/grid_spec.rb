require 'spec_helper'

describe Ronway::Grid do
  let(:grid) { Ronway::Grid.new(3) }

  it "accepts a size argument and generates a square gride" do
    expect(grid.state.length).to eq 9
  end

  it "create a grid of unique cells" do
    expect(grid[0, 0].object_id).not_to eq(grid[0, 1].object_id)
  end

  context "specifying an initial grid state" do
    it "can accept an initial grid state" do
      grid = Ronway::Grid.new(2, state: [:dead, :dead, :alive, :dead])
      expect(grid[0, 0].dead?).to be true
      expect(grid[0, 1].dead?).to be false
    end
  end

end
