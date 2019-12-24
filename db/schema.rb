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

ActiveRecord::Schema.define(version: 2019_12_24_175310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "start"
    t.datetime "end"
  end

  create_table "images", force: :cascade do |t|
    t.string "hash"
    t.string "uri"
    t.string "title"
    t.index ["hash"], name: "index_images_on_hash", unique: true
  end

  create_table "page_images", force: :cascade do |t|
    t.string "element_id"
    t.integer "page_id"
    t.integer "image_id"
  end

  create_table "page_texts", force: :cascade do |t|
    t.string "element_id"
    t.integer "page_id"
    t.integer "text_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "name"
  end

  create_table "privileges", force: :cascade do |t|
    t.string "name"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
  end

  create_table "texts", force: :cascade do |t|
    t.string "content"
  end

  create_table "user_privileges", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "privilege_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created"
    t.string "password"
    t.integer "role_id"
  end

  add_foreign_key "page_images", "images"
  add_foreign_key "page_images", "pages"
  add_foreign_key "page_texts", "pages"
  add_foreign_key "page_texts", "texts"
  add_foreign_key "staffs", "users"
  add_foreign_key "user_privileges", "privileges"
  add_foreign_key "user_privileges", "users"
  add_foreign_key "users", "roles"
end
