class CreateBookreads < ActiveRecord::Migration[7.1]
  def change
    create_table :bookreads do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
