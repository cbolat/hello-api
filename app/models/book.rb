class Book < ApplicationRecord
  # model association
  has_many :pages, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by
end
