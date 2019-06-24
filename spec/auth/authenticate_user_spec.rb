require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user_p) { create(:user_p)}

  subject(:valid_auth_obj) { described_class.new(user_p.email,user_p.password)}

  subject (:invalid_auth_obj) { described_class.new('foo','bar')}

  describe '#call' do
    context 'when valid credentials' do
      it 'returns an auth token' do
        token=valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
                  ExceptionHandler::AuthenticationError,
                  /Invalid credentials/
              )
      end
    end

  end

end