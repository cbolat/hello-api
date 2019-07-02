class Post < ApplicationRecord
  belongs_to :note

  validates_presence_of :name
end
