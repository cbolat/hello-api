require 'rails_helper'

RSpec.describe 'Customers API' do

  let(:userb) { create(:userb) }
  let!(:todo) { create(:todo, created_by: userb.id) }
  let!(:customers) { create_list(:customer, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { customers.first.id }

  let(:headers) { valid_headers }

  describe 'GET /todos/:todo_id/customers' do
    before { get "/todos/#{todo_id}/customers", params: {}, headers: headers }

    context 'when todo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all todo customers' do
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

  describe 'GET /todos/:todo_id/customers/:id' do
    before { get "/todos/#{todo_id}/customers/#{id}", params: {}, headers: headers }

    context 'when todo customer exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the customer' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when todo customer does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Customer/)
      end
    end
  end

  describe 'POST /todos/:todo_id/customers' do
    let(:valid_attributes) { { name: 'Keanu', done: false }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/todos/#{todo_id}/customers", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/todos/#{todo_id}/customers", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:todo_id/customers/:id' do
    let(:valid_attributes) { { name: 'Reeves' }.to_json }

    before do
      put "/todos/#{todo_id}/customers/#{id}", params: valid_attributes, headers: headers
    end

    context 'when customer exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the customer'do
        updated_customer = Customer.find(id)
        expect(updated_customer.name).to match(/Reeves/)
      end
    end

    context 'when the customer does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Customer/)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}/customers/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end