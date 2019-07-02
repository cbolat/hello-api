class Todo < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :customers, dependent: :destroy

  validates_presence_of :title, :created_by
end
