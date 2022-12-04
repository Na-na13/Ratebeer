require 'rails_helper'
include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
        sign_in(username: "Pekka", password: "wrong")
  
        expect(current_path).to eq(signin_path)
        expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
        visit signup_path
        fill_in('user_username', with: 'Brian')
        fill_in('user_password', with: 'Secret55')
        fill_in('user_password_confirmation', with: 'Secret55')
      
        expect{
          click_button('Create User')
        }.to change{User.count}.by(1)
    end
  end

  it "can see favorite beer style and brewery of others" do
    user = FactoryBot.create(:user, username: "Maija", password: "Foobar2", password_confirmation: "Foobar2")
    create_beers_with_many_ratings({user: user}, 20, 10, 5)
    best_brewery = FactoryBot.create(:brewery, name: "panimo")
    best_beer = FactoryBot.create(:beer, name: "paras", style: "IPA", brewery: best_brewery)
    FactoryBot.create(:rating, score: 45, beer: best_beer, user: user)
    visit user_path(user)
    expect(page).to have_content("favorite beer style is IPA")
    expect(page).to have_content("favorite brewery is panimo")
  end
end