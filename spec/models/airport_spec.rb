require 'rails_helper'

RSpec.describe Airport, type: :model do
  it { should validate_presence_of(:iata_code) }
  it { should have_many(:departured_flights).with_foreign_key('departured_id')
                                            .inverse_of(:departured) }
  it { should have_many(:arrived_flights).with_foreign_key('arrived_id')
                                         .inverse_of(:arrived) }
end
