class AddCurrentPageToBookreads < ActiveRecord::Migration[7.1]
  def change
    add_column :bookreads, :current_page, :integer
  end
end
