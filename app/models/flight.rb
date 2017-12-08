class Flight < ApplicationRecord
  belongs_to :user
  belongs_to :departured, class_name: 'Airport', foreign_key: 'departured_id'
  belongs_to :arrived, class_name: 'Airport', foreign_key: 'arrived_id'
end
