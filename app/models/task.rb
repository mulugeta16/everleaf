class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true , length: { in: 1..200 }
end
