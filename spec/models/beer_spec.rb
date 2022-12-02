require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with proper name, style and brewery" do
    test_brewery = Brewery.create name: "test", year: 2000
    beer = Beer.create name: "test_beer", style: "beer", brewery_id: test_brewery.id

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without name" do
    test_brewery = Brewery.new name: "test", year: 2000
    beer = Beer.create style: "beer", brewery: test_brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without style" do
    test_brewery = Brewery.new name: "test", year: 2000
    beer = Beer.create name: "test_beer", brewery: test_brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without existing brewery" do
    beer = Beer.create name: "test_beer", style: "beer", brewery_id: 200

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
