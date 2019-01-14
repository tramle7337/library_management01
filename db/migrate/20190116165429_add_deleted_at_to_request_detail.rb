class AddDeletedAtToRequestDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :request_details, :deleted_at, :datetime
  end
end
