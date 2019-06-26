class Singer < ApplicationRecord
  has_many :songs, dependent: :destroy

  validates_presence_of :name, :created_by
end
