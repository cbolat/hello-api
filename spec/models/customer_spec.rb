require 'rails_helper'

RSpec.describe Customer, type: :model do

  it { should belong_to(:todo) }

  it { should validate_presence_of(:name) }

end
