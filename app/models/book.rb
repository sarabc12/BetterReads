class Book < ApplicationRecord
  has_many :bookreads
  has_many :users, through: :bookreads

  has_many :booklists
  has_many :lists, through: :booklists

  has_many :reviews, dependent: :destroy
end
