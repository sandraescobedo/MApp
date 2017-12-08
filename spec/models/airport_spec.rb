require 'rails_helper'

RSpec.describe Airport, type: :model do
  it { should validate_presence_of(:iata_code) }
end
