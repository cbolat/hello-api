require 'rails_helper'

RSpec.describe 'Missions API' do
  # Initialize the test data
  let(:user_p) {create (:user_p)}
  let!(:todo) { create(:todo,created_by: user_p.id) }
  let!(:missions) { create_list(:mission, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { missions.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /todos/:todo_id/missions
  describe 'GET /todos/:todo_id/missions' do
    before { get "/todos/#{todo_id}/missions", params: {}, headers: headers }

    context 'when todo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all todo missions' do
        expect(json.size).to eq(20)
      end
    end

    context 'when todo does not exist' do
      let(:todo_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # Test suite for GET /todos/:todo_id/missions/:id
  describe 'GET /todos/:todo_id/missions/:id' do
    before { get "/todos/#{todo_id}/missions/#{id}", params: {}, headers: headers }

    context 'when todo mission exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the mission' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when todo mission does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Mission/)
      end
    end
  end

  describe 'POST /todos/:todo_id/missions' do
    let(:valid_attributes) { { code: 'CodeName'}.to_json }

    context 'when request attributes are valid' do
      before do
        post "/todos/#{todo_id}/missions", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/todos/#{todo_id}/missions", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Code can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/orders/:id
  describe 'PUT /todos/:todo_id/missions/:id' do
    let(:valid_attributes) { { code: 'Mozart' }.to_json }

    before do
      put "/todos/#{todo_id}/missions/#{id}", params: valid_attributes, headers: headers
    end

    context 'when order exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the mission' do
        updated_mission = Mission.find(id)
        expect(updated_mission.code).to match(/Mozart/)
      end
    end

    context 'when the mission does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Mission/)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}/missions/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end