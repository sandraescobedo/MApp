require 'rails_helper'

RSpec.describe Flight, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:departured).class_name('Airport')
                                    .with_foreign_key('departured_id') }
  it { should belong_to(:arrived).class_name('Airport')
                                  .with_foreign_key('arrived_id') }

  before(:all) do
    @admin = create(:user, role: 'admin')
    @user = create(:user)
    @airport1 = create(:airport, iata_code: 'VLC')
    @airport2 = create(:airport, iata_code: 'LGW')
    @flight = create(:flight, user_id: @user.id, departured_id: @airport1.id,
                      arrived_id: @airport2.id)
  end

  context 'for a flight' do
    it 'departured_airport and arrived_airport are differents' do
      expect(@flight.check_departured_and_arrived).to be_nil
    end
  end
  
  context 'if run arrived_airport_code' do
    it 'returns iata_code' do
      expect(@flight.arrived_airport_code).to eq(@airport2.iata_code)
    end
  end

  context 'if run departured_airport_code' do
    it 'returns iata_code' do
      expect(@flight.departured_airport_code).to eq(@airport1.iata_code)
    end
  end

end
