class AddDeletedAtToAuthor < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :deleted_at, :datetime
  end
end
