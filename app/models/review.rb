class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rating, presence: true
  validates :description, presence: true
  # validates :date, presence: true
end
