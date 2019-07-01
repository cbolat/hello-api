class Animal < ApplicationRecord
  belongs_to :farm

  # validation
  validates_presence_of :name
end
