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

ActiveRecord::Schema.define(version: 2020_01_04_212159) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amazon_credentials", force: :cascade do |t|
    t.string "access_key_id"
    t.string "secret_access_key"
    t.string "bucket_name"
    t.string "user"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  create_table "exception_logs", force: :cascade do |t|
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
    t.integer "user_id"
    t.string "token_payload"
    t.string "log_message"
    t.string "exception_message"
    t.string "stacktrace"
    t.string "ip_address"
    t.string "request"
    t.string "response"
    t.string "params"
    t.string "raw_request"
    t.string "raw_response"
    t.integer "severity"
    t.string "response_body"
    t.string "request_params"
  end

  create_table "media", force: :cascade do |t|
    t.integer "media_type_id"
    t.string "checksum"
    t.string "file_extension"
    t.string "uri"
    t.string "title"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  create_table "media_types", force: :cascade do |t|
    t.string "mime_primary_type"
    t.string "mime_sub_type"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  create_table "password_reset_keys", force: :cascade do |t|
    t.string "reset_key"
    t.integer "user_id"
    t.boolean "active"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  create_table "privileges", force: :cascade do |t|
    t.string "name"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  create_table "texts", force: :cascade do |t|
    t.string "content"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  create_table "user_privileges", force: :cascade do |t|
    t.integer "user_id"
    t.integer "privilege_id"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.integer "role_id"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
    t.boolean "active"
    t.string "auth_token"
    t.datetime "last_request_time"
  end

  create_table "view_media", force: :cascade do |t|
    t.string "identifier"
    t.integer "view_id"
    t.integer "medium_id"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  create_table "view_texts", force: :cascade do |t|
    t.string "identifier"
    t.integer "view_id"
    t.integer "text_id"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  create_table "views", force: :cascade do |t|
    t.string "name"
    t.datetime "created"
    t.datetime "last_updated"
    t.integer "last_updated_by"
  end

  add_foreign_key "events", "users", column: "last_updated_by"
  add_foreign_key "media", "users", column: "last_updated_by"
  add_foreign_key "media_types", "users", column: "last_updated_by"
  add_foreign_key "privileges", "users", column: "last_updated_by"
  add_foreign_key "roles", "users", column: "last_updated_by"
  add_foreign_key "staffs", "users"
  add_foreign_key "staffs", "users", column: "last_updated_by"
  add_foreign_key "texts", "users", column: "last_updated_by"
  add_foreign_key "user_privileges", "privileges"
  add_foreign_key "user_privileges", "users"
  add_foreign_key "user_privileges", "users", column: "last_updated_by"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "users", column: "last_updated_by"
  add_foreign_key "view_media", "media"
  add_foreign_key "view_media", "users", column: "last_updated_by"
  add_foreign_key "view_media", "views"
  add_foreign_key "view_texts", "texts"
  add_foreign_key "view_texts", "users", column: "last_updated_by"
  add_foreign_key "view_texts", "views"
  add_foreign_key "views", "users", column: "last_updated_by"
end
