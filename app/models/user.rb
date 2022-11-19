class User < ApplicationRecord
  include RatingAverage

  has_many :ratings, dependent: destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: destroy
  has_many :beer_clubs, through: :memberships
  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 30}
  validates :password, length: { minimum: 4 }

  validate :password_contain_capital_letter, :password_contain_number, on: :create

  def password_contain_capital_letter
    match = password =~ /[A-Z]/
    if match.nil?
      errors.add(:password, " has to contain min. 1 capital letter")
    end
  end

  def password_contain_number
    match = password =~ /[0-9]/
    if match.nil?
      errors.add(:password, " has to contain min. 1 number")
    end
  end

end
