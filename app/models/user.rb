class User < ApplicationRecord
  belongs_to :job

  validates_presence_of :name
end
