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

ActiveRecord::Schema.define(version: 20130715020018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "aka"
    t.string   "job"
    t.text     "bio"
    t.date     "dob"
    t.date     "dod"
    t.string   "email"
    t.string   "social"
    t.string   "website"
    t.string   "type"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "reset_token"
    t.datetime "reset_token_sent_at"
    t.integer  "fans_count",          default: 0
    t.integer  "idols_count",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "origins", force: true do |t|
    t.string   "title"
    t.string   "original_title"
    t.date     "publication"
    t.text     "content"
    t.text     "info"
    t.string   "video"
    t.string   "link"
    t.integer  "author_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raspas", force: true do |t|
    t.text     "quote"
    t.integer  "user_id"
    t.integer  "author_id"
    t.integer  "origin_id"
    t.text     "note"
    t.boolean  "published",       default: true
    t.integer  "citations_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reaspas", force: true do |t|
    t.integer  "raspa_id"
    t.integer  "author_id"
    t.integer  "original_author"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reaspas", ["author_id"], name: "index_reaspas_on_author_id"
  add_index "reaspas", ["raspa_id"], name: "index_reaspas_on_raspa_id"

  create_table "relationships", force: true do |t|
    t.integer  "author_id"
    t.integer  "idol_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["author_id"], name: "index_relationships_on_author_id"
  add_index "relationships", ["idol_id"], name: "index_relationships_on_idol_id"

  create_table "taggings", force: true do |t|
    t.integer  "raspa_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
