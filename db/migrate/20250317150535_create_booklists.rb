class CreateBooklists < ActiveRecord::Migration[7.1]
  def change
    create_table :booklists do |t|
      t.references :list, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
