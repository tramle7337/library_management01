class ChangeDataTypeForColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :role, :integer, null: false
  end
end
