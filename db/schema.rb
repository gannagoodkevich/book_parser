# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_31_200232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.integer "cover_id"
    t.integer "genre_id"
    t.integer "status_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id", "author"], name: "index_books_on_id_and_author", unique: true
    t.index ["id", "title"], name: "index_books_on_id_and_title", unique: true
    t.index ["id"], name: "index_books_on_id", unique: true
  end

  create_table "covers", force: :cascade do |t|
    t.string "cover_type"
    t.integer "book_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "index_covers_on_id", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "title"
    t.integer "book_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "index_genres_on_id", unique: true
  end

  create_table "statuses", force: :cascade do |t|
    t.string "status_title"
    t.integer "book_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "index_statuses_on_id", unique: true
  end

end
