require 'rails_helper'

RSpec.describe AirportsController, type: :controller do
  let(:valid_session) { {} }
  before do
    @user = double('User', id: Faker::Number.number(10),
                           email: Faker::Internet.email,
                           password: Faker::Alphanumeric.alphanumeric)
    allow(@user).to receive(:confirmed?).and_return(true)
    allow(request.env['warden']).to receive(:authenticate!).and_return(@user)
    allow(controller).to receive(:current_user).and_return(@user)
    @params_airport = { 'airport' => { 'iata_code' => 'AAA' } }
  end

  describe 'GET #index' do
    before do
      get :index, session: valid_session
    end

    it 'assigns @airports' do
      expect(assigns(:airports)).to eq(Airport.all)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before do
      post :create, session: valid_session, params: @params_airport
    end
    it 'assigns @airport' do
      params_id = { 'id' => Airport.last.id }
      get :show, params: params_id, session: valid_session
      expect(assigns(:airport)).to eq(Airport.find(params_id['id']))
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
      post :create, session: valid_session, params: @params_airport
      @new_iata_code = 'ZZZ'
      @new_params_airport = { 'id' => Airport.last.id,
                              'airport' => { 'iata_code' => @new_iata_code } }
      put :update, params: @new_params_airport, session: valid_session
    end

    it 'updates the requested Airport' do
      expect(Airport.last.iata_code).to eq(@new_iata_code)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:found)
    end

    it 'redirects to the updated airport' do
      expect(response).to redirect_to(Airport.find(@new_params_airport['id']))
    end
  end

  describe 'POST #create' do
    before do
      post :create, session: valid_session, params: @params_airport
    end

    it 'assigns @customer' do
      expect(assigns(:airport)).to eq(Airport.last)
    end

    it 'creates a new Airport' do
      expect {
        post :create, params: @params_airport, session: valid_session
      }.to change(Airport, :count).by(1)
    end

    it 'redirects to the created customer' do
      expect(response).to redirect_to(Airport.last)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET #edit' do
    before do
      post :create, session: valid_session, params: @params_airport
      get :edit, params: { 'id' => Airport.last }, session: valid_session
    end

    it 'assigns @airport' do
      expect(assigns(:airport)).to eq(Airport.last)
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

    it 'assigns @airport' do
      expect(assigns(:airport)).to be_a_new(Airport)
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
      post :create, params: @params_airport, session: valid_session
      @airport_id = Airport.last.id
      delete :destroy, session: valid_session,
             params: { 'id' => Airport.last.id }
    end

    it 'deletes a requested Airport' do
      expect(Airport.last.id).not_to eq(@airport_id)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:found)
    end

    it 'redirects to index' do
      expect(response).to redirect_to('/airports')
    end
  end
end
