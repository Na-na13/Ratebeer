class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating(beer)
        sum = 0
        count = 0 
        beer.ratings.each do |rating|
            sum += rating.score
            count += 1
        end
        average = sum/count
        average.to_f
    end
end
