class Mission < ApplicationRecord
  belongs_to :todo

  validates_presence_of :code
end
