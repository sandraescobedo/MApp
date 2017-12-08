class Airport < ApplicationRecord
  has_many :departured_flights, class_name: 'Flight', foreign_key: 'departured_id', inverse_of: 'departured'
  has_many :arrived_flights, class_name: 'Flight', foreign_key: 'arrived_id', inverse_of: 'arrived'
  validates :iata_code, presence: true
end
