class Style < ApplicationRecord
  has_many :beer
  has_many :ratings, through: :beers

  def self.top(n)
    ratings_by_style = {}
    Rating.all.group_by{ |rating| rating.beer.style }.each do |group|
      ratings_by_style[group[0]] = group[1].sum(&:score) / group[1].count.to_f
    end
    ratings_by_style.sort_by{ |hash| hash[1] }.reverse.first(n)
  end
end
