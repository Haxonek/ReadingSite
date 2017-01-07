# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170107051733) do

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.boolean  "complete"
    t.integer  "volumes"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "tags",                                default: ""
    t.integer  "volume",                              default: 0
    t.text     "content"
    t.decimal  "rating",      precision: 3, scale: 2
    t.integer  "book_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "chapters", ["book_id"], name: "index_chapters_on_book_id"

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.decimal  "rating",     precision: 3, scale: 2
    t.integer  "chapter_id"
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "comments", ["book_id"], name: "index_comments_on_book_id"
  add_index "comments", ["chapter_id"], name: "index_comments_on_chapter_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "description",            default: ""
    t.string   "name",                   default: "",    null: false
    t.boolean  "admin",                  default: false
    t.boolean  "locked",                 default: false
    t.datetime "sub_end"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
