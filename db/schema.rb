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

ActiveRecord::Schema.define(version: 2026_07_20_120302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domains", force: :cascade do |t|
    t.string "host"
    t.integer "kind"
    t.bigint "university_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["university_id"], name: "index_domains_on_university_id"
  end

  create_table "pages", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.string "name"
    t.string "permalink"
    t.integer "position"
    t.boolean "visible", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["permalink"], name: "index_pages_on_permalink"
    t.index ["subject_id"], name: "index_pages_on_subject_id"
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.string "name"
    t.integer "position"
    t.boolean "visible", default: false
    t.string "content_type"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_id"], name: "index_sections_on_page_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", limit: 20
    t.integer "position"
    t.boolean "visible", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subjects_universities", id: false, force: :cascade do |t|
    t.bigint "university_id", null: false
    t.bigint "subject_id", null: false
    t.index ["subject_id", "university_id"], name: "index_subjects_universities_on_subject_id_and_university_id", unique: true
    t.index ["university_id", "subject_id"], name: "index_subjects_universities_on_university_id_and_subject_id", unique: true
  end

  create_table "subjects_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "subject_id", null: false
    t.index ["subject_id", "user_id"], name: "index_subjects_users_on_subject_id_and_user_id"
    t.index ["user_id", "subject_id"], name: "index_subjects_users_on_user_id_and_subject_id", unique: true
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.integer "users_count", default: 0, null: false
    t.integer "subjects_count", default: 0, null: false
    t.index ["slug"], name: "index_universities_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username", default: "", null: false
    t.integer "role", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "university_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["university_id"], name: "index_users_on_university_id"
  end

  add_foreign_key "domains", "universities"
  add_foreign_key "pages", "subjects"
  add_foreign_key "sections", "pages"
  add_foreign_key "users", "universities"
end
