class Airport < ApplicationRecord
  has_many :flights, inverse_of: 'origin_airport'
  has_many :flights, inverse_of: 'destination_airport'
end
