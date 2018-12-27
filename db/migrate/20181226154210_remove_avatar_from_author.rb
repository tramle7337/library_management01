class RemoveAvatarFromAuthor < ActiveRecord::Migration[5.2]
  def change
    remove_column :authors, :avatar, :string
  end
end
