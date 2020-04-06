class CreateStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.string :status_title
      t.integer :book_id

      t.timestamps
    end

    add_index :statuses, :id, unique: true
  end
end
