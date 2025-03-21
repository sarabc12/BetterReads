class Book < ApplicationRecord
  has_many :bookreads
  has_many :users, through: :bookreads

  has_many :booklists
  has_many :lists, through: :booklists

  has_many :reviews, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_neighbors :embedding
  # after_create :set_embedding

  private

  def set_embedding
    client = OpenAI::Client.new
    response = client.embeddings(
      parameters: {
        model: "text-embedding-3-small",
        input: "Book : #{title}. Genre: #{genre}"
      }
    )
    embedding = response["data"][0]["embedding"]
    update(embedding: embedding)
  end
end
