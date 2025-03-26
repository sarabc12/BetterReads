class List < ApplicationRecord
  belongs_to :user

  has_many :booklists, dependent: :destroy
  has_many :books, through: :booklists

  validates :title, presence: true, uniqueness: { scope: :user_id }
end
