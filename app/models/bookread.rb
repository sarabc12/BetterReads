class Bookread < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :status, presence: true, inclusion: { in: ["want to read", "currently reading", "finished"] }
  validates :current_page, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
