class BeerClub < ApplicationRecord
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  validates :name, :founded, :city, presence: true

  def to_s
    name.to_s
  end
end
