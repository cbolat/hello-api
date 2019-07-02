class Project < ApplicationRecord
  include Filterable

  has_many :employees, dependent: :destroy

  validates_presence_of :title, :created_by

  scope :starts_with, -> (title) { where("title like ?", "#{title}%")}

end
