class AddStatusToBookreads < ActiveRecord::Migration[7.1]
  def change
    add_column :bookreads, :status, :string
  end
end
