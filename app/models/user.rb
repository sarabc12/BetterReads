class User < ApplicationRecord
  has_many :lists
  has_many :reviews

  has_many :bookreads
  has_many :books, through: :bookreads

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_default_lists

  private

  def create_default_lists
    ["Want to Read", "Currently Reading", "Read"].each do |list_name|
      lists.find_or_create_by(title: list_name)
    end
  end
end
