require 'rails_helper'

RSpec.describe 'Jobs API', type: :request do
  let!(:jobs) {create_list(:job, 10)}
  let(:job_id) {jobs.first.id}

  describe 'GET.jobs' do
    before { get '/jobs'}

    it 'returns jobs' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET /jobs/:id' do
    before { get "/jobs/#{job_id}"}

    context 'when the record exists' do
      it 'returns the job' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(job_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:job_id) {100}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Job/)
      end

    end

  end

  describe 'POST /jobs' do
    let(:valid_attributes) {{title: 'Manager', description: 'Manages other employees'}}

    context 'when the request is valid' do
      before { post '/jobs', params: valid_attributes}

      it 'creates a job' do
        expect(json['title']).to eq('Manager')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/jobs', params: {title: 'Foobar'}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Description can't be blank/)
      end
    end

  end

  describe 'PUT /jobs/:id' do
    let(:valid_attributes) {{title: 'COO'}}

    context 'when the record exists' do
      before { put "/jobs/#{job_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /jobs/:id' do
    before { delete "/jobs/#{job_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end