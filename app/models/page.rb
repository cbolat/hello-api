class Page < ApplicationRecord
  # model association
  belongs_to :book

  # validation
  validates_presence_of :title, :created_by
end
