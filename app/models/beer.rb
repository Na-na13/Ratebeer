class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings, dependent: :destroy
    include RatingAverage

    def to_s
        "#{name}, #{brewery.name}"
    end
end
