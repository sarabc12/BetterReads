class User < ApplicationRecord
  has_many :lists
  has_many :reviews

  has_many :bookreads
  has_many :books, through: :bookreads
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
