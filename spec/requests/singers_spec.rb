require 'rails_helper'

RSpec.describe 'Singer API', type: :request do
  # add singers owner
  let(:user) { create(:user) }
  let!(:singers) { create_list(:singer, 10, created_by: user.id) }
  let(:singer_id) { singers.first.id }
  # authorize request
  let(:headers) { valid_headers }

  describe 'GET /singers' do
    # update request with headers
    before { get '/singers', params: {}, headers: headers }

    it 'returns singers' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /singers/:id' do
    before { get "/singers/#{singer_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the singer' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(singer_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:singer_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

     it 'returns a not found message' do
       expect(response.body).to match(/Couldn't find Singer/)


    end
  end

  describe 'POST /singers' do
    let(:valid_attributes) do
      # send json payload
      { name: 'Learn Elm', created_by: user.id.to_s }.to_json
    end

    context 'when request is valid' do
      before { post '/singers', params: valid_attributes, headers: headers }

      it 'creates a singer' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { name: nil }.to_json }
      before { post '/singers', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
            .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /singers/:id' do
    let(:valid_attributes) { { name: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/singers/#{singer_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /singers/:id' do
    before { delete "/singers/#{singer_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
  end
  end
