# spec/requests/items_spec.rb
require 'rails_helper'

RSpec.describe 'Pages API' do
  # Initialize the test data
  let(:user) {create(:user)}
  let!(:book) { create(:book) }
  let!(:pages) { create_list(:page, 20, book_id: book.id) }
  let(:book_id) { book.id }
  let(:id) { pages.first.id }
  let(:headers) {valid_headers}

  # Test suite for GET /books/:book_id/pages
  describe 'GET /books/:book_id/pages' do
    before { get "/books/#{book_id}/pages", params:{}, headers: headers }

    context 'when book exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all book pages' do
        expect(json.size).to eq(20)
      end
    end

    context 'when book does not exist' do
      let(:book_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Book/)
      end
    end
  end

  # Test suite for GET /books/:book_id/pages/:id
  describe 'GET /books/:book_id/pages/:id' do
    before { get "/books/#{book_id}/pages/#{id}", params:{}, headers: headers }

    context 'when book page exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the page' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when book page does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Page/)
      end
    end
  end

  # Test suite for PUT /books/:book_id/pages
  describe 'POST /books/:book_id/pages' do
    let(:valid_attributes) { { title: 'Visit Narnia', created_by: book.id }.to_json }

    context 'when request attributes are valid' do
      before { post "/books/#{book_id}/pages", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/books/#{book_id}/pages", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /books/:book_id/pages/:id
  describe 'PUT /books/:book_id/pages/:id' do
    let(:valid_attributes) { { title: 'Mozart' }.to_json }

    before { put "/books/#{book_id}/pages/#{id}", params: valid_attributes, headers: headers }

    context 'when page exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the page' do
        updated_item = Page.find(id)
        expect(updated_item.title).to match(/Mozart/)
      end
    end

    context 'when the page does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Page/)
      end
    end
  end

  # Test suite for DELETE /books/:id
  describe 'DELETE /books/:id' do
    before { delete "/books/#{book_id}/pages/#{id}", params:{}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end