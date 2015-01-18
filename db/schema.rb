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

ActiveRecord::Schema.define(version: 20150118025522) do

  create_table "assets", force: true do |t|
    t.string   "type"
    t.string   "assetable_type"
    t.integer  "assetable_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "categories_lists", force: true do |t|
    t.integer "category_id"
    t.integer "list_id"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "likes", force: true do |t|
    t.string   "likable_type"
    t.integer  "likable_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["likable_type", "likable_id", "user_id"], name: "index_likes_on_likable_type_and_likable_id_and_user_id", unique: true, using: :btree

  create_table "list_items", force: true do |t|
    t.integer  "list_id"
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "likes_count", default: 0
  end

  add_index "list_items", ["list_id", "product_id"], name: "index_list_items_on_list_id_and_product_id", unique: true, using: :btree

  create_table "lists", force: true do |t|
    t.boolean  "active",         default: false
    t.string   "name"
    t.integer  "products_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "user_id"
    t.integer  "current_score"
    t.integer  "total_score"
  end

  add_index "lists", ["slug"], name: "index_lists_on_slug", unique: true, using: :btree

  create_table "products", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "manufacturer"
    t.string   "sku"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_cents",  default: 0
    t.string   "slug"
    t.integer  "category_id"
  end

  add_index "products", ["type", "sku"], name: "index_products_on_type_and_sku", unique: true, using: :btree

  create_table "products_subcategories", force: true do |t|
    t.integer "product_id"
    t.integer "subcategory_id"
  end

  create_table "scores", force: true do |t|
    t.string   "scorable_type"
    t.integer  "scorable_id"
    t.string   "actionable_type"
    t.integer  "actionable_id"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subcategories", force: true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcategories", ["category_id", "name"], name: "index_subcategories_on_category_id_and_name", unique: true, using: :btree
  add_index "subcategories", ["name"], name: "index_subcategories_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "api_token"
    t.string   "role",                   default: "user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_score"
    t.integer  "total_score"
  end

  add_index "users", ["api_token"], name: "index_users_on_api_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
