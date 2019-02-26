require 'rails_helper'

RSpec.describe ApartmentsFeed, type: :service do
  let(:rental_agencies) { {"A" => 10, "B" => 8, "C" => 2} }
  
  subject(:feed) { ApartmentsFeed.new(apartments, rental_agencies).call }

  context "when all apartments are duplicate" do
    let(:apartments) do
      [
          {"address"=>"88th Street", "apartment"=>"5D", "city"=>"NY", "price"=>"$2550", "rental_agency"=>"B"},
          {"address"=>"88th Street", "apartment"=>"5D", "city"=>"NY", "price"=>"$2450", "rental_agency"=>"A"},
          {"address"=>"88th Street", "apartment"=>"5D", "city"=>"NY", "price"=>"$2750", "rental_agency"=>"C"}
      ]
    end

    it "returns only one apartment" do
      expect(feed.count).to eq(1)
    end

    it "selects apartment with the highest priority rental agency" do
      expect(feed.first.rental_agency).to eq("A")
    end
  end

  context "when all apartments are unique" do
    let(:apartments) do
      [
          {"address"=>"1st Street", "apartment"=>"5D", "city"=>"NY", "price"=>"$2550", "rental_agency"=>"B"},
          {"address"=>"2nd Street", "apartment"=>"7A", "city"=>"NY", "price"=>"$2450", "rental_agency"=>"A"},
          {"address"=>"3rd Street", "apartment"=>"4B", "city"=>"NY", "price"=>"$2750", "rental_agency"=>"C"}
      ]
    end

    it "returns the same number of apartments" do
      expect(feed.count).to eq(3)
    end
  end

end