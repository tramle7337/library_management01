class AddNoteColumnToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :note, :string
  end
end
