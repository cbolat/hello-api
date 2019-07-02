require 'rails_helper'

RSpec.describe 'Posts API' do
  let(:userb) { create(:userb) }
  let!(:note) { create(:note, created_by: userb.id) }
  let!(:posts) { create_list(:post, 20, note_id: note.id) }
  let(:note_id) { note.id }
  let(:id) { posts.first.id }
  
  let(:headers) { valid_headers }

  describe 'GET /notes/:note_id/posts' do
    before { get "/notes/#{note_id}/posts", params: {}, headers: headers }

    context 'when note exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all note posts' do
        expect(json.size).to eq(20)
      end
    end

    context 'when note does not exist' do
      let(:note_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end


  describe 'GET /notes/:note_id/posts/:id' do
    before { get "/notes/#{note_id}/posts/#{id}", params: {}, headers: headers }

    context 'when note post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the post' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when note post does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end


  describe 'POST /notes/:note_id/posts' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/notes/#{note_id}/posts", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/notes/#{note_id}/posts", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end


  describe 'PUT /notes/:note_id/posts/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before do
      put "/notes/#{note_id}/posts/#{id}", params: valid_attributes, headers: headers
    end

    context 'when post exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the post' do
        updated_post = Post.find(id)
        expect(updated_post.name).to match(/Mozart/)
      end
    end

    context 'when the post does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end


  describe 'DELETE /notes/:id' do
    before { delete "/notes/#{note_id}/posts/#{id}" , params: {}, headers: headers}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end