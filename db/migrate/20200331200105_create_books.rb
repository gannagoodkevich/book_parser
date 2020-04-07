class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :cover_id
      t.integer :genre_id
      t.integer :status_id

      t.timestamps
    end

    add_index :books, :id, unique: true
    add_index :books, %i[id title], unique: true
    add_index :books, %i[id author], unique: true
      # add_index :books, :genre_id
  end
end
