class Flight < ApplicationRecord
  belongs_to :user
  belongs_to :origin_airport, class_name: 'Airport', foreign_key: 'origin_airport_id'
  belongs_to :destination_airport, class_name: 'Airport', foreign_key: 'destination_airport_id'
end
