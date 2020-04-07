class CreateCovers < ActiveRecord::Migration[6.0]
  def change
    create_table :covers do |t|
      t.string :cover_type
      t.integer :book_id

      t.timestamps
    end

    add_index :covers, :id, unique: true
  end
end
