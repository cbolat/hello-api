class Todo < ApplicationRecord
  # model association
  has_many :items, dependent: :destroy
  # validations
  validates_presence_of :title, :created_by
  include Filterable
  scope :titlegit, -> title { where(title: title)}
   # scope :starts_with, -> title { where("title like ?" ,"#{title}")}
end


