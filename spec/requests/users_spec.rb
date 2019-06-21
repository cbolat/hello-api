require 'rails_helper'

RSpec.describe 'Users API' do
  let!(:job) { create(:job) }
  let!(:users ) { create_list(:user,10, job_id:job.id)}
  let(:job_id) { job.id }
  let(:id) { users.first.id }

  describe 'GET /jobs/:job_id/users' do
    before { get "/jobs/#{job_id}/users"}

    context 'when job exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all job users' do
        expect(json.size).to eq(10)
      end
    end

    context 'when job does not exist' do
      let(:job_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Job/)
      end

    end

  end

  describe 'GET /jobs/:job_id/users/:id' do
    before { get "/jobs/#{job_id}/users/#{id}"}

    context 'when job user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns user' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when job user does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end

  end

  describe 'POST /jobs/:job_id/users' do
    let(:valid_attributes) {{ name:'Ion Pop'}}

    context 'when request attributes are valid' do
      before { post "/jobs/#{job_id}/users", params: valid_attributes }

      it 'returns code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before{ post "/jobs/#{job_id}/users", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /jobs/:job_id/users/:id' do
    let(:valid_attributes) { { name: 'Sandel'}}
    before { put "/jobs/#{job_id}/users/#{id}", params: valid_attributes }

    context 'when user exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_item = User.find(id)
        expect(updated_item.name).to match(/Sandel/)
      end
    end

    context 'when the user does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'DELETE /jobs/:id' do
    before { delete "/jobs/#{job_id}/users/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end