#
#
# # spec/requests/todos_spec.rb
# require 'rails_helper'
#
# RSpec.describe 'Todos API', type: :request do
#   # add todos owner
#   let(:user) { create(:user) }
#   let!(:todos) { create_list(:todo, 10, created_by: user.id) }
#   let(:todo_id) { todos.first.id }
#   # authorize request
#   let(:headers) { valid_headers }
#
#   describe 'GET /todos' do
#     # update request with headers
#     before { get '/todos', params: {}, headers: headers }
#
#     # [...]
#   end
#
#   describe 'GET /todos/:id' do
#     before { get "/todos/#{todo_id}", params: {}, headers: headers }
#     # [...]
#   end
#   # [...]
# end
#
# describe 'POST /todos' do
#   let(:valid_attributes) do
#     # send json payload
#     { title: 'Learn Elm', created_by: user.id.to_s }.to_json
#   end
#
#   context 'when request is valid' do
#     before { post '/todos', params: valid_attributes, headers: headers }
#     # [...]
#   end
#
#   context 'when the request is invalid' do
#     let(:invalid_attributes) { { title: nil }.to_json }
#     before { post '/todos', params: invalid_attributes, headers: headers }
#
#     it 'returns status code 422' do
#       expect(response).to have_http_status(422)
#     end
#
#     it 'returns a validation failure message' do
#       expect(json['message'])
#           .to match(/Validation failed: Title can't be blank/)
#     end
#   end
#
#   describe 'PUT /todos/:id' do
#     let(:valid_attributes) { { title: 'Shopping' }.to_json }
#
#     context 'when the record exists' do
#       before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }
#       # [...]
#     end
#   end
#
#   describe 'DELETE /todos/:id' do
#     before { delete "/todos/#{todo_id}", params: {}, headers: headers }
#     # [...]
#   end
# end



require 'rails_helper'

RSpec.describe 'Items API' do
  let(:user) { create(:user) }
  let!(:todo) { create(:todo, created_by: user.id) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }
  let(:headers) { valid_headers }

  describe 'GET /todos/:todo_id/items' do
    before { get "/todos/#{todo_id}/items", params: {}, headers: headers }

    # [...]
  end

  describe 'GET /todos/:todo_id/items/:id' do
    before { get "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

    # [...]
  end

  describe 'POST /todos/:todo_id/items' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/todos/#{todo_id}/items", params: valid_attributes, headers: headers
      end

      # [...]
    end

    context 'when an invalid request' do
      before { post "/todos/#{todo_id}/items", params: {}, headers: headers }

      # [...]
    end
  end

  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before do
      put "/todos/#{todo_id}/items/#{id}", params: valid_attributes, headers: headers
    end

    # [...]
    # [...]
  end

  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

    # [...]
  end
end