require 'rails_helper'

RSpec.describe Book, type: :model do
  it { expect have_many(:pages).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { expect validate_presence_of(:title) }
  it { expect validate_presence_of(:created_by) }
end
