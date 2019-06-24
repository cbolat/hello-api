class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  # validations
  validates_presence_of :name, :created_by
end
