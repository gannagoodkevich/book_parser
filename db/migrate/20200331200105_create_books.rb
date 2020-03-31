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
  end
end
