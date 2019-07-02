require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  let!(:userb) { create(:userb) }

  let(:headers) { { 'Authorization' => token_generator(userb.id) } }
  let(:invalid_headers) { { 'Authorization' => nil } }

  describe "#authorize_request" do
    context "when auth token is passed" do
      before { allow(request).to receive(:headers).and_return(headers) }

      it "sets the current userb" do
        expect(subject.instance_eval { authorize_request }).to eq(userb)
      end
    end

    context "when auth token is not passed" do
      before do
        allow(request).to receive(:headers).and_return(invalid_headers)
      end

      it "raises MissingToken error" do
        expect { subject.instance_eval { authorize_request } }.
            to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end

end