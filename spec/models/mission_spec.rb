require 'rails_helper'

RSpec.describe Mission, type: :model do
  it { should belong_to(:todo)}

  it { should validate_presence_of(:code)}
end
