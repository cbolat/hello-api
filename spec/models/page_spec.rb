require 'rails_helper'

RSpec.describe Page, type: :model do
  it { expect belong_to(:book) }
  # Validation test
  # ensure column name is present before saving
  it { expect validate_presence_of(:title) }
  it { expect validate_presence_of(:created_by) }
end
