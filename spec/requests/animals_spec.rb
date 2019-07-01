require 'rails_helper'

RSpec.describe 'Animals API' do
  # Initialize the test data
  #let!(:farm) { create(:farm) }




  let(:user) { create(:user) }
  let!(:farm) { create(:farm, created_by: user.id) }
  let!(:animals) { create_list(:animal, 20, farm_id: farm.id) }
  #let!(:animas) { create_list(:animal, 20, farm_id: farm.id) }
  let(:farm_id) { farm.id }
  #let(:todo_id) { todo.id }
  let(:id) { animals.first.id }
  let(:headers) { valid_headers }


  # Test suite for GET /farms/:farm_id/animals
  describe 'GET /farms/:farm_id/animals' do
    #before { get "/farms/#{farm_id}/animals" }
    before { get "/farms/#{farm_id}/animals", params: {}, headers: headers }

    context 'when farm exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all farm animals' do
        expect(json.size).to eq(20)
      end
    end

    context 'when farm does not exist' do
      let(:farm_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Farm/)
      end
    end
  end

  # Test suite for GET /farms/:farm_id/animals/:id
  describe 'GET /farms/:farm_id/animals/:id' do
    #before { get "/farms/#{farm_id}/animals/#{id}" }
    before { get "/farms/#{farm_id}/animals/#{id}", params: {}, headers: headers }

    context 'when farm animal exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the animal' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when farm animal does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Animal/)
      end
    end
  end

  # Test suite for PUT /farms/:farm_id/animals
  describe 'POST /farms/:farm_id/animals' do
    #let(:valid_attributes) { { name: 'Visit Narnia', done: false } }
    let(:valid_attributes) { { name: 'Visit Narnia', done: false }.to_json }

    context 'when request attributes are valid' do
      #before { post "/farms/#{farm_id}/animals", params: valid_attributes }
      before do
        post "/farms/#{farm_id}/animals", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      #before { post "/farms/#{farm_id}/animals", params: {} }
      before { post "/farms/#{farm_id}/animals", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /farms/:farm_id/animals/:id
  describe 'PUT /farms/:farm_id/animals/:id' do
    #let(:valid_attributes) { { name: 'Mozart' } }
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    #before { put "/farms/#{farm_id}/animals/#{id}", params: valid_attributes }
    before do
      put "/farms/#{farm_id}/animals/#{id}", params: valid_attributes, headers: headers
    end

    context 'when animal exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the animal' do
        updated_animal = Animal.find(id)
        expect(updated_animal.name).to match(/Mozart/)
      end
    end

    context 'when the animal does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Animal/)
      end
    end
  end

  # Test suite for DELETE /farms/:id
  describe 'DELETE /farms/:id' do
    #before { delete "/farms/#{farm_id}/animals/#{id}" }
    before { delete "/farms/#{farm_id}/animals/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end