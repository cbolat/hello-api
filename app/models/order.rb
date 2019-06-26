class Order < ApplicationRecord
  belongs_to :todo

  validates_presence_of :name
  validates_presence_of :price
end
