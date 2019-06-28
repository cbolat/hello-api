require 'rails_helper'

RSpec.describe Animal, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to(:farm) }
  it { should validate_presence_of(:name) }
end
