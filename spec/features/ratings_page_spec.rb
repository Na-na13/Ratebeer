require 'rails_helper'
include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "page shows all ratings and amount of all ratings" do
    FactoryBot.create(:rating, beer: beer2, score: 10, user: user)
    visit ratings_path

    expect(page).to have_content "Number of ratings: 1"
    expect(page).to have_content "Karhu: 10"

    FactoryBot.create(:rating, beer: beer1, score: 20, user: user)
    visit ratings_path

    expect(page).to have_content "Number of ratings: 2"
    expect(page).to have_content "iso 3: 20"
  end

  it "of user are shown correctly on user's own page" do
    FactoryBot.create(:rating, beer: beer2, score: 10, user: user)
    FactoryBot.create(:rating, beer: beer2, score: 15, user: user)
    FactoryBot.create(:rating, beer: beer2, score: 20, user: user)
    user2 = FactoryBot.create(:user, username: "Paavo", password: "Password1", password_confirmation: "Password1")
    FactoryBot.create(:rating, beer: beer2, score: 30, user: user2)
    visit user_path(user)

    expect(page).to have_content "Pekka has 3 ratings with an average of 15.0"
    expect(page).to have_content "Karhu: 10"
    expect(page).to have_content "Karhu: 15"
    expect(page).to have_content "Karhu: 20"
    expect(page).not_to have_content "Karhu: 30"
  end

  it "when deleted, is not shown on any page" do
    rating1 = create_beer_with_rating({ user: user }, 20 )
    rating2 = create_beer_with_rating({ user: user }, 10 )
    visit user_path(user)
    expect(page).to have_content "Pekka has 2 ratings with an average of 15.0"
    # within(rating2) do
    #  click_on "delete"
    # end
    # within rating2 do
    #  click_button("delete", :match => :first)
    # end
  end
end
