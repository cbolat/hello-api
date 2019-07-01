require 'rails_helper'

RSpec.describe 'Projects API', type: :request do

  let(:userb) { create(:userb) }
  let!(:projects) { create_list(:project, 10, created_by: userb.id) }
  let(:project_id) { projects.first.id }
  let(:headers) { valid_headers }

  describe "GET /projects" do

    before { get '/projects', params: {}, headers: headers }

    it 'retruns projects' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /projects/:id' do
    before { get "/projects/#{project_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the project' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(project_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:project_id) { 999 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end


  describe 'POST /projects' do

    let (:valid_attributes) do
      { title: 'Generate Reports', created_by:userb.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/projects', params: valid_attributes, headers: headers }

      it 'creates a project' do
        expect(json['title']).to eq('Generate Reports')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/projects', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message']).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /projects/:id' do
    let(:valid_attributes) { { title: 'Rebuild wireframe' }.to_json }

    context 'when the record exists' do
      before { put "/projects/#{project_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /projects/:id' do
    before { delete "/projects/#{project_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end







end