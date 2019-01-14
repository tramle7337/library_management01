class AddDeletedAtToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :deleted_at, :datetime
  end
end
