class Shelter < ApplicationRecord
  ColumnNames = ["accepting", "address", "address_name", "city", "county", "id", "latitude", "longitude", "notes", "pets", "phone", "shelter", "source", "supply_needs", "updated_by", "volunteer_needs", "last_updated", "latitude", "longitude"]

  HeaderNames = ColumnNames.map(&:titleize)

  UpdateFields = ["accepting", "address", "address_name", "city", "county", "notes", "pets", "phone", "shelter", "source", "supply_needs", "updated_by", "volunteer_needs", "last_updated", "latitude", "longitude"]

  has_many :drafts, as: :record
  default_scope { where(active: !false) }

  geocoded_by :address

  after_commit do
    ShelterUpdateNotifierJob.perform_later self
  end
end
