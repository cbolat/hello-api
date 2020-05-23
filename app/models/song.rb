class Song < ApplicationRecord

  belongs_to :singer

  validates_presence_of :name
end
