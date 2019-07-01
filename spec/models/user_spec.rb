# spec/models/user_spec.rb
require 'rails_helper'

# Test suite for User model
RSpec.describe User, type: :model do
  # Association test
  # ensure User model has a 1:m relationship with the Todo model
  it { expect have_many(:todos) }
  it { expect have_many(:books) }
  # Validation tests
  # ensure name, email and password_digest are present before save
  it { expect validate_presence_of(:name) }
  it { expect validate_presence_of(:email) }
  it { expect validate_presence_of(:password_digest) }
end