class User < ApplicationRecord
  include RatingAverage

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 30 }
  validates :password, length: { minimum: 4 }

  validate :password_contain_capital_letter, :password_contain_number, on: :create

  def password_contain_capital_letter
    match = password =~ /[A-Z]/
    return unless match.nil?

    errors.add(:password, " has to contain min. 1 capital letter")
  end

  def password_contain_number
    match = password =~ /[0-9]/
    return unless match.nil?

    errors.add(:password, " has to contain min. 1 number")
  end

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil, jos reittauksia ei ole

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?  # palauttaa nil, jos reittauksia ei ole

    average_scores = {}
    ratings.group_by { |r| r.beer.style }.each do |beer|
      average_scores[beer[0]] = beer[1].sum(&:score) / beer[1].count.to_f
    end
    average_scores.sort_by{ |score| score[1] }.reverse[0][0]
  end

  def favorite_brewery
    return nil if ratings.empty?  # palauttaa nil, jos reittauksia ei ole

    average_scores = {}
    ratings.group_by { |r| r.beer.brewery }.each do |brewery|
      average_scores[brewery[0].name] = brewery[1].sum(&:score) / brewery[1].count.to_f
    end
    average_scores.sort_by{ |score| score[1] }.reverse[0][0]
  end

  def self.top(n)
    ratings_by_user = {}
    User.all.each do |user|
      if user.ratings.any?
        ratings_by_user[user.username] = user.ratings.count
      end
    end
    ratings_by_user.sort_by{ |hash| hash[1] }.reverse.first(n)
  end
end
