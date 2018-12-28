class AddPictureToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :picture, :string
  end
end
