class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true
  validate :brewery_exists, on: :create

  def to_s
    "#{name}, #{brewery.name}"
  end

  def brewery_exists
    existing_brewery = Brewery.find_by id: brewery_id
    return unless existing_brewery.nil?

    errors.add(:brewery, "has to exist")
  end

  def self.top(int)
    sorted_by_rating_in_desc_order = Beer.all.sort_by(&:average_rating).reverse
    sorted_by_rating_in_desc_order[0..(int - 1)]
  end
end
