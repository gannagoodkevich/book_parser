class CreateGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :genres do |t|
      t.string :title
      t.integer :book_id

      t.timestamps
    end

    add_index :genres, :id, unique: true
  end
end
