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

ActiveRecord::Schema.define(version: 20170105174732) do

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

end
