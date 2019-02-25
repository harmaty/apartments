class ApartmentsController < ApplicationController
  def feed
    @apartments = ApartmentsFeed.new(ApartmentsLoader.new.call, RentalAgenciesLoader.new.call).call
  end
end