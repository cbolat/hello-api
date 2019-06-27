require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:todo)}

  it { should validate_presence_of(:name)}

  it { should validate_presence_of(:price)}
end
