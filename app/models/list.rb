class List < ApplicationRecord
  belongs_to :user

  has_many :booklists
  has_many :books, through: :booklists
end
