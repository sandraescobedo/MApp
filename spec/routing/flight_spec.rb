require 'rails_helper'

describe FlightsController do
  describe 'routing' do
    it { expect(get: '/flights').to route_to('flights#index') }
    it { expect(get: '/flights/new').to route_to('flights#new') }
    it { expect(get: '/flights/1').to route_to('flights#show', id: '1') }
    it { expect(get: '/flights/1/edit').to route_to('flights#edit', id: '1') }
    it { expect(post: '/flights').to route_to('flights#create') }
    it { expect(put: '/flights/1').to route_to('flights#update', id: '1') }
    it { expect(patch: '/flights/1').to route_to('flights#update', id: '1') }
    it { expect(delete: '/flights/1').to route_to('flights#destroy', id: '1') }
  end
end
