# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_09_01_201805) do
  create_table "authors", force: :cascade do |t|
    t.string "forename"
    t.string "surname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.string "nationality"
  end

  create_table "book_goals", force: :cascade do |t|
    t.string "month"
    t.string "year"
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_goals_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rating"
    t.integer "series_id"
    t.integer "series_position"
    t.integer "total_pages"
    t.boolean "purchased", default: true
    t.datetime "deleted_at"
    t.string "status", default: "Unread"
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["deleted_at"], name: "index_books_on_deleted_at"
    t.index ["series_id"], name: "index_books_on_series_id"
  end

  create_table "books_genres", id: false, force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "genre_id", null: false
    t.index ["book_id"], name: "index_books_genres_on_book_id"
    t.index ["genre_id"], name: "index_books_genres_on_genre_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loaners", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rentals", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "loaner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.datetime "deleted_at"
    t.index ["book_id"], name: "index_rentals_on_book_id"
    t.index ["deleted_at"], name: "index_rentals_on_deleted_at"
    t.index ["loaner_id"], name: "index_rentals_on_loaner_id"
  end

  create_table "series", force: :cascade do |t|
    t.string "name"
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_series_on_author_id"
  end

  add_foreign_key "book_goals", "books"
  add_foreign_key "books", "authors"
  add_foreign_key "books", "series"
  add_foreign_key "rentals", "books"
  add_foreign_key "rentals", "loaners"
  add_foreign_key "series", "authors"
end
