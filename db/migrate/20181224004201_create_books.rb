class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.references :category, foreign_key: true
      t.references :author, foreign_key: true
      t.references :publisher, foreign_key: true
      t.string :name
      t.text :content
      t.integer :number_of_pages
      t.integer :year
      t.integer :number_of_books

      t.timestamps
    end
  end
end
