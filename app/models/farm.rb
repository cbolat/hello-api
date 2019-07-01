class Farm < ApplicationRecord
  has_many :animals, dependent: :destroy
  validates_presence_of :name, :created_by
end
