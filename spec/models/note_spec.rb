require 'rails_helper'

RSpec.describe Note, type: :model do

  it { should have_many(:posts).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }

end
