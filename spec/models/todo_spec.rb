require 'rails_helper'

RSpec.describe Todo, type: :model do

  # one to many relationship
  it{ should have_many(:items).dependent(:destroy)}

  #ensure that columns are present
  it{ should validate_presence_of(:title)}
  it{ should validate_presence_of(:created_by)}
end
