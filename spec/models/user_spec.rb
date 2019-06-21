require 'rails_helper'

RSpec.describe User, type: :model do

  it { should belong_to(:job)}

  it { should validate_presence_of(:name)}
end
