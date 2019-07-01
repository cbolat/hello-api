class Project < ApplicationRecord

  has_many :employees, dependent: :destroy

  validates_presence_of :title, :created_by

end
