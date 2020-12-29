class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(date_1, date_2)
    start_date = Date.parse date_1
    end_date = Date.parse date_2
    open_listings = []
    self.neighborhoods.each do |neighborhood|
      neighborhood.listings.each do |listing|
        open_listings << listing 
      end
    end
    open_listings.each do |listing|
      listing.reservations.each do |res|
        if res.array_of_dates.include?(start_date) || res.array_of_dates.include?(end_date)
          open_listings.delete(listing)
        end
      end
    end
    open_listings
  end
  
  # def self.highest_ratio_res_to_listings
  # end

  # def self.most_res
  #   City.find_by(city: params[:city])
  # end



end

