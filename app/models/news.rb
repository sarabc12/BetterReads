class News < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
 # validates :picture, presence: true, format: { with: /\A(http|https):\/\/.*\.(jpg|jpeg|png|gif)\z/ }
end
