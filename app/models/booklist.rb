class Booklist < ApplicationRecord
  belongs_to :list
  belongs_to :book
end
