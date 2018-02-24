class Flight < ApplicationRecord
  belongs_to :user
  belongs_to :departured, class_name: 'Airport', foreign_key: 'departured_id'
  belongs_to :arrived, class_name: 'Airport', foreign_key: 'arrived_id'

  scope :by_user, ->(user) { where(user: user) }

  def arrived_airport_code
    Airport.find_by_id(arrived_id)&.iata_code
  end

  def departured_airport_code
    Airport.find_by_id(departured_id)&.iata_code
  end
end
