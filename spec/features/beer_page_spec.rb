require 'rails_helper'
include Helpers

describe "Beers page" do
  let!(:user) {FactoryBot.create :user}
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  
  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "should allow to add new beer with valid name" do
    visit new_beer_path
    fill_in('beer[name]', with: 'Olut')
    select('Lager', from: 'beer[style]')
    select('Koff', from: 'beer[brewery_id]')

    expect{
        click_button "Create Beer"
        }.to change{Beer.count}.from(0).to(1)
  end

  it "shoul not allow to add new beer if name is not valid" do
    visit new_beer_path
    select('Lager', from: 'beer[style]')
    select('Koff', from: 'beer[brewery_id]')
    click_button "Create Beer"

    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(0)
  end
end
