require 'rails_helper'

RSpec.describe FlightsController, type: :controller do
  let(:valid_session) { {} }
  before do
    @user = create(:user,  email: Faker::Internet.email,
                           password: Faker::Alphanumeric.alphanumeric,
                           role: 'admin')
    @airport1 = create(:airport, iata_code: 'AAA', name: 'Barajas')
    @airport2 = create(:airport, iata_code: 'BBB', name: 'El Prat')
    @params_flight = { 'flight' => { 'departured_id' => @airport1.id,
      'arrived_id' => @airport2.id, 'user_id' => @user.id  } }
    @user.confirm
    allow(request.env['warden']).to receive(:authenticate!).and_return(@user)
    allow(controller).to receive(:current_user).and_return(@user)
  end

  describe 'GET #index' do
    xit 'assigns @flights' do
      get :index, session: valid_session, params: {}
      expect(assigns(:flights)).to eq(Flight.all.order('departured_date DESC'))
    end

    it 'if user exists, assigns @my_flights to true' do
      params = { user: 1 }
      get :index, session: valid_session, params: params
      expect(assigns(:my_flights)).to be true
    end

    it 'if user not exists, assigns @my_flights to false' do
      params = {}
      get :index, session: valid_session, params: params
      expect(assigns(:my_flights)).to be false
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    before do
      post :create, session: valid_session, params: @params_flight
    end
    it 'assigns @flight' do
      params_id = { 'id' => Flight.last.id }
      get :show, params: params_id, session: valid_session
      expect(assigns(:flight)).to eq(Flight.find(params_id['id']))
    end

    it 'returns a success response' do
      get :index, session: valid_session
      expect(response).to have_http_status(:ok)
    end

    it 'renders index template' do
      get :index, session: valid_session
      expect(response).to render_template(:index)
    end
  end

  describe 'PUT #update' do
    before do
      post :create, session: valid_session, params: @params_flight
      @new_date = Faker::Date.backward(1000)
      @new_params_flight = { 'id' => Flight.last.id,
                             'flight' => { 'departured_date' => @new_date } }
      put :update, params: @new_params_flight, session: valid_session
    end

    it 'updates the requested Flight' do
      expect(Flight.last.departured_date).to eq(@new_date)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:found)
    end

    it 'redirects to the updated flight' do
      expect(response).to redirect_to(Flight.find(@new_params_flight['id']))
    end
  end

  describe 'POST #create' do
    before do
      post :create, session: valid_session, params: @params_flight
    end

    it 'assigns @customer' do
      expect(assigns(:flight)).to eq(Flight.last)
    end

    it 'creates a new Flight' do
      expect {
        post :create, params: @params_flight, session: valid_session
      }.to change(Flight, :count).by(1)
    end

    it 'redirects to the created customer' do
      expect(response).to redirect_to(Flight.last)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET #edit' do
    before do
      post :create, session: valid_session, params: @params_flight
      get :edit, params: { 'id' => Flight.last }, session: valid_session
    end

    it 'assigns @flight' do
      expect(assigns(:flight)).to eq(Flight.last)
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'renders edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET #new' do
    before do
      get :new, session: valid_session
    end

    it 'assigns @flight' do
      expect(assigns(:flight)).to be_a_new(Flight)
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE #destroy' do
    before do
      post :create, params: @params_flight, session: valid_session
      @flight_id = Flight.last.id
      delete :destroy, session: valid_session,
             params: { 'id' => Flight.last.id }
    end

    it 'deletes a requested Flight' do
      expect(Flight.last.id).not_to eq(@flight_id)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:found)
    end

    it 'redirects to index' do
      expect(response).to redirect_to('/flights')
    end
  end
end
