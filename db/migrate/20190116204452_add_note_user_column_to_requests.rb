class AddNoteUserColumnToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :note_user, :string
  end
end
