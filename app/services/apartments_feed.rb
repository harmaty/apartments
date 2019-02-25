class ApartmentsFeed
  attr_accessor :apartments, :rental_agencies

  def initialize(apartments, rental_agencies)
    @apartments = apartments
    @rental_agencies = rental_agencies
  end

  def call
    apartments.group_by{ |apartment| apartment.slice("address", "apartment", "city") }.values
        .map{ |aps| aps.sort_by{ |a| rental_agencies[a["rental_agency"]]}.last }
        .map{ |apartment| Apartment.new apartment }
  end

end