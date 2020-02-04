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

ActiveRecord::Schema.define(version: 2018_12_26_041940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "billing_addresses", force: :cascade do |t|
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "prefecture"
    t.string "zip_code"
    t.integer "buyer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_billing_addresses_on_buyer_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buyer_profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "buyer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_buyer_profiles_on_buyer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.string "subject"
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "follows", force: :cascade do |t|
    t.string "followable_type", null: false
    t.bigint "followable_id", null: false
    t.string "follower_type", null: false
    t.bigint "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["followable_type", "followable_id"], name: "index_follows_on_followable_type_and_followable_id"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
    t.index ["follower_type", "follower_id"], name: "index_follows_on_follower_type_and_follower_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "images", force: :cascade do |t|
    t.string "image"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "price", default: 0
    t.text "description"
    t.integer "shipping_fees", default: 0
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "brand_id"
    t.integer "sub_category_id"
    t.integer "seller_id"
    t.boolean "publish", default: true
    t.datetime "deleted_at"
    t.integer "purchase_count", default: 0
    t.string "slug"
    t.index ["deleted_at"], name: "index_items_on_deleted_at"
  end

  create_table "items_sizes", id: false, force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "size_id"
    t.index ["item_id"], name: "index_items_sizes_on_item_id"
    t.index ["size_id"], name: "index_items_sizes_on_size_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "item_id"
    t.integer "purchase_order_id"
    t.integer "buyer_id"
    t.integer "quantity_id"
    t.integer "unit_price"
    t.integer "unit_shipping_fees"
    t.integer "total_price"
    t.string "size"
    t.integer "seller_id"
    t.string "seller_name"
    t.string "item_name"
    t.string "order_status", default: "InProgress"
    t.boolean "reviewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_order_items_on_buyer_id"
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["purchase_order_id"], name: "index_order_items_on_purchase_order_id"
    t.index ["quantity_id"], name: "index_order_items_on_quantity_id"
    t.index ["seller_id"], name: "index_order_items_on_seller_id"
  end

  create_table "payment_accounts", force: :cascade do |t|
    t.integer "buyer_id"
    t.integer "card_no"
    t.string "card_type"
    t.string "stripe_customer_id"
    t.integer "exp_month"
    t.integer "exp_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_payment_accounts_on_buyer_id"
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.integer "buyer_id"
    t.integer "sum_price"
    t.integer "sum_shipping_fees"
    t.integer "total_price"
    t.string "status", default: "Pending"
    t.string "stripe_charge_id"
    t.integer "payment_account_id"
    t.datetime "purchase_date"
    t.string "billing_address_1"
    t.string "billing_address_2"
    t.string "billing_prefecture"
    t.string "billing_zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_purchase_orders_on_buyer_id"
    t.index ["payment_account_id"], name: "index_purchase_orders_on_payment_account_id"
  end

  create_table "quantities", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "size_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "remaining"
    t.integer "purchased", default: 0
    t.index ["item_id"], name: "index_quantities_on_item_id"
    t.index ["size_id"], name: "index_quantities_on_size_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "description"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "item_id"
    t.integer "seller_id"
    t.integer "buyer_id"
  end

  create_table "seller_admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seller_id"
    t.index ["email"], name: "index_seller_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_seller_admins_on_reset_password_token", unique: true
  end

  create_table "seller_profiles", force: :cascade do |t|
    t.integer "seller_id"
    t.string "name"
    t.string "photo"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "instagram_url"
    t.string "twitter_url"
    t.string "line_url"
    t.string "facebook_url"
    t.boolean "hide", default: false
    t.integer "num_of_items", default: 0
  end

  create_table "sizes", force: :cascade do |t|
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_categories", force: :cascade do |t|
    t.integer "category_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "slug"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
