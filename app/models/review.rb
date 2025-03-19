class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rating, inclusion: { in: 1..5 }
  validates :description, presence: true
  # validates :date, presence: true
end
