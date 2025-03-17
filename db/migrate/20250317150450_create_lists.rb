class CreateLists < ActiveRecord::Migration[7.1]
  def change
    create_table :lists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.date :date
      t.string :description

      t.timestamps
    end
  end
end
