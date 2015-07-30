require 'spec_helper'

describe Ronway::Cell do
  let(:cell) { Ronway::Cell.new }

  it 'can be alive or dead' do
    cell.live!
    expect(cell.alive?).to be true
    cell.die!
    expect(cell.dead?).to be true
  end

  it 'can be set to alive or dead' do
    cell = Ronway::Cell.new(:dead)
    expect(cell.alive?).to be false
  end
end
