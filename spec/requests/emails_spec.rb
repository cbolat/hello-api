require 'rails_helper'
=begin
RSpec.describe 'Emails API', type: :request do
  let(:email) {"carla.morar@yahoo.com"}
  let(:user_p) {create (:user_p)}
  let(:headers) { valid_headers }
  describe 'POST /emails' do
    context 'when valid request' do
      before { post "/email", params: :email, headers: headers }
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
=end