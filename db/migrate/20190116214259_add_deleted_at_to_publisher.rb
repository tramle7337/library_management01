class AddDeletedAtToPublisher < ActiveRecord::Migration[5.2]
  def change
    add_column :publishers, :deleted_at, :datetime
  end
end
