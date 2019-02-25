class RentalAgenciesLoader
  def call
    YAML.load(File.read Rails.root.join("db", "rental_agencies.yml"))
  end
end
