class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.string :genre
      t.date :release_date
      t.string :picture
      t.integer :book_length

      t.timestamps
    end
  end
end
