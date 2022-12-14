require 'rails_helper'
include Helpers

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username: "Pekka", password: "aa1", password_confirmation: "aa1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with password containing only lower case letters" do
    user = User.create username: "Pekka", password: "password", password_confirmation: "password" 

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryBot.create(:user) }
    
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determinig the favorite beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
    
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )
    
      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite style" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without rating does not have a favorite style" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the one of rated's if only one rating" do
      create_beer_with_rating({user: user}, 20)
      expect(user.favorite_style.name).to eq("Lager")
    end

    it "is the one with average highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 20, 10, 5)
      best_style = FactoryBot.create(:style)
      best = FactoryBot.create(:beer, name: "paras", style: best_style)
      FactoryBot.create(:rating, score: 45, beer: best, user: user)
      expect(user.favorite_style.name).to eq("Lager")
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite brewery" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without rating does not have a favorite brewery" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the one of rated's if only one rating" do
      create_beer_with_rating({user: user}, 20)
      expect(user.favorite_brewery).to eq("anonymous")
    end

    it "is the one with average highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 20, 10, 5)
      best_brewery = FactoryBot.create(:brewery, name: "panimo")
      best_style = FactoryBot.create(:style)
      best_beer = FactoryBot.create(:beer, name: "paras", style: best_style, brewery: best_brewery)
      FactoryBot.create(:rating, score: 45, beer: best_beer, user: user)
      expect(user.favorite_brewery).to eq("panimo")
    end
  end
end
