require 'rails_helper'

describe AirportsController do
  describe 'routing' do
    it { expect(get: '/airports').to route_to('airports#index') }
    it { expect(get: '/airports/new').to route_to('airports#new') }
    it { expect(get: '/airports/1').to route_to('airports#show', id: '1') }
    it { expect(get: '/airports/1/edit').to route_to('airports#edit', id: '1') }
    it { expect(post: '/airports').to route_to('airports#create') }
    it { expect(put: '/airports/1').to route_to('airports#update', id: '1') }
    it { expect(patch: '/airports/1').to route_to('airports#update', id: '1') }
    it { expect(delete: '/airports/1').to route_to('airports#destroy', id: '1') }
  end
end
