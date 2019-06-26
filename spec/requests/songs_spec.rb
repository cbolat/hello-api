require 'rails_helper'

RSpec.describe 'Songs API' do
  let(:user) { create(:user) }
  let!(:singer) { create(:singer, created_by: user.id) }
  let!(:songs) { create_list(:song, 20, singer_id: singer.id) }
  let(:singer_id) { singer.id }
  let(:id) { songs.first.id }
  let(:headers) { valid_headers }

  describe 'GET /singers/:singer_id/songs' do
    before { get "/singers/#{singer_id}/songs", params: {}, headers: headers }

    context 'when singer exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all singer songs' do
        expect(json.size).to eq(20)
      end
    end

    context 'when singer does not exist' do
      let(:singer_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

#      it 'returns a not found message' do
      #  gerexpect(response.body).to match(/Couldn't find sin/)
     # end
    end
  end

  describe 'GET /singers/:singer_id/songs/:id' do
    before { get "/singers/#{singer_id}/songs/#{id}", params: {}, headers: headers }

    context 'when singer song exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the song' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when singer song does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      #it 'returns a not found message' do
        #expect(response.body).to match(/Couldn't find song/)
      #end
    end
  end

  describe 'POST /singers/:singer_id/songs' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/singers/#{singer_id}/songs", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/singers/#{singer_id}/songs", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /singers/:singer_id/songs/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before do
      put "/singers/#{singer_id}/songs/#{id}", params: valid_attributes, headers: headers
    end

    context 'when song exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the song' do
        updated_song = Song.find(id)
        expect(updated_song.name).to match(/Mozart/)
      end
    end

    context 'when song does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

#      it 'returns a not found message' do
      #  expect(response.body).to match(/Couldn't find song/)
      #end
    end
  end

  describe 'DELETE /singers/:id' do
    before { delete "/singers/#{singer_id}/songs/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
