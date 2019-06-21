class Job < ApplicationRecord
  has_many :users, dependent: :destroy

  validates_presence_of :title, :description
end
