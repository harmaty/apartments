class ApartmentsLoader
  def call
    YAML.load(File.read Rails.root.join("db", "apartments.yml"))
  end
end