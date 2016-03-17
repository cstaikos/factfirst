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

ActiveRecord::Schema.define(version: 20160317002443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evidences", force: :cascade do |t|
    t.string   "url"
    t.boolean  "support"
    t.integer  "user_id"
    t.integer  "fact_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.string   "title"
    t.integer  "source_id"
  end

  add_index "evidences", ["fact_id"], name: "index_evidences_on_fact_id", using: :btree
  add_index "evidences", ["user_id"], name: "index_evidences_on_user_id", using: :btree

  create_table "facts", force: :cascade do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "score"
    t.integer  "category_id"
  end

  add_index "facts", ["category_id"], name: "index_facts_on_category_id", using: :btree
  add_index "facts", ["created_at"], name: "index_facts_on_created_at", using: :btree
  add_index "facts", ["score"], name: "index_facts_on_score", using: :btree
  add_index "facts", ["user_id"], name: "index_facts_on_user_id", using: :btree

  create_table "facts_users", force: :cascade do |t|
    t.integer "fact_id"
    t.integer "user_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string   "domain"
    t.integer  "wot_trust"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "wot_confidence"
  end

  create_table "users", force: :cascade do |t|
    t.string   "display_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.boolean  "upvote"
    t.integer  "evidence_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "votes", ["evidence_id"], name: "index_votes_on_evidence_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
