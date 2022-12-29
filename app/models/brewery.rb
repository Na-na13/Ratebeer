class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   only_integer: true }
  validate :year_less_than_or_equal_this_year, on: :create

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def year_less_than_or_equal_this_year
    return unless year > Time.now.year

    errors.add(:year, " is invalid")
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end

  def self.top(int)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by(&:average_rating).reverse
    sorted_by_rating_in_desc_order[0..(int - 1)]
  end
end
