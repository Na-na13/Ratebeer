require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )
    allow(BeerweatherApi).to receive(:get_weather).with("kumpula").and_return(
      @weather = {
        :temperature => "-20",
        :icons => [],
        :wind_speed => "20",
        :wind_dir => "N"
      }
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple is returned by the API, all are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name: "Oljenkorsi", id: 1 ),
          Place.new( name: "Baari", id: 2 )]
      )
    allow(BeerweatherApi).to receive(:get_weather).with("kumpula").and_return(
        @weather = {
          :temperature => "-20",
          :icons => [],
          :wind_speed => "20",
          :wind_dir => "N"
        }
      )
  
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Baari"
  end

  it "if none is returned by the API, appropriate message is shown" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return([])
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page). to have_content "No locations in Kumpula"
  end
end