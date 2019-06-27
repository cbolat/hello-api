require "rails_helper"
=begin
RSpec.describe UserMailer, type: :mailer do
  let(:email){ "carla.morar@yahoo.com" }
  #let(:mail) { described_class.welcome_email(user).deliver_now}
   subject { described_class.welcome_email(email).deliver_now }
  it 'renders the subject' do
    expect(subject.subject).to eq('Welcome to Hello API')
  end

  it 'renders the receiver email' do
    expect(subject.to).to eq(['carla.morar@yahoo.com'])
  end

  it 'renders the sender email' do
    expect(subject.from).to eq(['helloapi@example.com'])
  end
end
=end