class ApartmentsFeed < Struct.new(:apartments, :rental_agencies)
  def call
    apartments.group_by{ |apartment| apartment.slice("address", "apartment", "city") }
        .values
        .map{ |aps| aps.sort_by{ |ap| rental_agencies[ap["rental_agency"]] }.last }
        .map{ |apartment| Apartment.new apartment }
  end
end