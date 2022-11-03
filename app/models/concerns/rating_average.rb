module RatingAverage
    extend ActiveSupport::Concern

    def average_rating
        ratings.average(:score)
        #ratings.map{|rating|rating[ :score].to_i}.reduce(:+)
    end
end