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

ActiveRecord::Schema.define(version: 20140610013241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotations", force: true do |t|
    t.integer  "relation_instance_id"
    t.integer  "user_id"
    t.integer  "annotation"
    t.boolean  "is_bad_pattern"
    t.text     "ambiguity_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datasets", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "datasets", ["name"], name: "index_datasets_on_name", unique: true, using: :btree

  create_table "relation_instances", force: true do |t|
    t.integer "dataset_id"
    t.integer "sentence_id"
    t.string  "mid1",          limit: 10
    t.integer "extent1_begin"
    t.integer "extent1_end"
    t.string  "extent1_text",  limit: 200
    t.string  "mid2",          limit: 10
    t.integer "extent2_begin"
    t.integer "extent2_end"
    t.string  "extent2_text",  limit: 200
    t.string  "relation",      limit: 200
  end

  add_index "relation_instances", ["dataset_id"], name: "index_relation_instances_on_dataset_id", using: :btree
  add_index "relation_instances", ["sentence_id"], name: "index_relation_instances_on_sentence_id", using: :btree

  create_table "sentences", id: false, force: true do |t|
    t.integer "sentence_id"
    t.integer "dataset_id"
    t.text    "sentence"
  end

  add_index "sentences", ["dataset_id"], name: "index_sentences_on_dataset_id", using: :btree
  add_index "sentences", ["sentence_id"], name: "index_sentences_on_sentence_id", using: :btree

  create_table "user_sentence_completed", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "sentence_id"
    t.integer "dataset_id"
  end

  add_index "user_sentence_completed", ["dataset_id"], name: "index_user_sentence_completed_on_dataset_id", using: :btree
  add_index "user_sentence_completed", ["sentence_id"], name: "index_user_sentence_completed_on_sentence_id", using: :btree
  add_index "user_sentence_completed", ["user_id"], name: "index_user_sentence_completed_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
