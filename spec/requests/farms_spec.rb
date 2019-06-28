require 'rails_helper'

RSpec.describe 'Farms API', type: :request do
  # initialize test data
  #let!(:farms) { create_list(:farm, 10) }
  #let(:farm_id) { farms.first.id }

  let(:user) { create(:user) }
  let!(:farms) { create_list(:farm, 10, created_by: user.id) }
  let(:farm_id) { farms.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /farms
  describe 'GET /farms' do
    # make HTTP get request before each example
    #before { get '/farms' }
    before { get '/farms', params: {}, headers: headers }

    it 'returns farms' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /farms/:id
  describe 'GET /farms/:id' do
    #before { get "/farms/#{farm_id}" }
    before { get "/farms/#{farm_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the farm' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(farm_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:farm_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Farm/)
      end
    end
  end

  # Test suite for POST /farms
  describe 'POST /farms' do
    # valid payload
    #let(:valid_attributes) { { title: 'Learn Elm', created_by: '1' } }
    let(:valid_attributes) do
      # send json payload
      { name: 'Learn Elm', created_by: user.id.to_s }.to_json
    end

    context 'when the request is valid' do

      #before { post '/farms', params: valid_attributes }
      before { post '/farms', params: valid_attributes, headers: headers }

      it 'creates a farm' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do

      let(:invalid_attributes) { { name: nil }.to_json }
      before { post '/farms', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        # expect(response.body)
        #     .to match(/Validation failed: Created by can't be blank/)
        expect(json['message'])
            .to match(/Validation failed: Name can't be blank/)
      # end
      end
    end
  end

  # Test suite for PUT /farms/:id
  describe 'PUT /farms/:id' do
    #let(:valid_attributes) { { title: 'Shopping' } }
    let(:valid_attributes) { { name: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/farms/#{farm_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /farms/:id
  describe 'DELETE /farms/:id' do
    #before { delete "/farms/#{farm_id}" }
    before { delete "/farms/#{farm_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end