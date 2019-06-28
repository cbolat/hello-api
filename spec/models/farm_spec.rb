require 'rails_helper'

RSpec.describe Farm, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it { should have_many(:animals).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_by) }
end
