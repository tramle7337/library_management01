class CreateRequestDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :request_details do |t|
      t.references :book, foreign_key: true
      t.references :request, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
