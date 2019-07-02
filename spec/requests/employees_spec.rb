require 'rails_helper'

RSpec.describe 'Employees API' do

  let(:userb) { create(:userb) }
  let!(:project) { create(:project, created_by: userb.id) }
  let!(:employees) { create_list(:employee, 20, project_id: project.id) }
  let(:project_id) { project.id }
  let(:id) { employees.first.id }

  let(:headers) { valid_headers }

  describe 'GET /projects/:project_id/employees' do
    before { get "/projects/#{project_id}/employees", params: {}, headers: headers }

    context 'when project exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all project employees' do
        expect(json.size).to eq(20)
      end
    end

    context 'when project does not exist' do
      let(:project_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end

  describe 'GET /projects/:project_id/employees/:id' do
    before { get "/projects/#{project_id}/employees/#{id}", params: {}, headers: headers }

    context 'when project employee exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the employee' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when project employee does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Employee/)
      end
    end
  end

  describe 'POST /projects/:project_id/employees' do
    let(:valid_attributes) { { name: 'John Wick', paid: false }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/projects/#{project_id}/employees", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/projects/#{project_id}/employees", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /projects/:project_id/employees/:id' do
    let(:valid_attributes) { { name: 'Michael Cage' }.to_json }

    before do
      put "/projects/#{project_id}/employees/#{id}", params: valid_attributes, headers: headers
    end

    context 'when employee exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the employee' do
        updated_employee = Employee.find(id)
        expect(updated_employee.name).to match(/Michael Cage/)
      end
    end

    context 'when the employee does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Employee/)
      end
    end
  end

  describe 'DELETE /project/:id' do
    before { delete "/projects/#{project_id}/employees/#{id}", params: {}, headers: headers}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end