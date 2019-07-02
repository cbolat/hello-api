class Userb < ApplicationRecord


  has_many :todos, foreign_key: :created_by
  has_many :projects, foreign_key: :created_by
  has_many :notes, foreign_key: :created_by

  validates_presence_of :name, :email, :password

end
