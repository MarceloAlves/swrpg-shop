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

ActiveRecord::Schema.define(version: 2019_12_14_063934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "armors", force: :cascade do |t|
    t.string "key", null: false
    t.string "name", null: false
    t.text "description"
    t.text "sources", default: [], array: true
    t.integer "defense"
    t.integer "soak"
    t.integer "price", default: 0, null: false
    t.integer "encumbrance"
    t.integer "hard_points"
    t.integer "rarity", default: 0
    t.text "categories", default: [], array: true
    t.boolean "is_restricted", default: false
    t.json "base_mods", default: []
    t.json "weapon_modifiers", default: []
    t.string "type"
    t.string "image_filename", default: "missing.png"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gears", force: :cascade do |t|
    t.string "key", null: false
    t.string "name", null: false
    t.text "description"
    t.string "short"
    t.string "type"
    t.text "categories", default: [], array: true
    t.integer "encumbrance", default: 0
    t.integer "hard_points"
    t.integer "price", default: 0, null: false
    t.integer "rarity", default: 0
    t.boolean "is_restricted", default: false
    t.text "sources", default: [], array: true
    t.string "image_filename", default: "missing.png"
    t.json "base_mods", default: []
    t.json "weapon_modifiers", default: []
    t.string "adv_import_path"
    t.json "modifiers", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_attachments", force: :cascade do |t|
    t.string "key", null: false
    t.string "name", null: false
    t.text "description"
    t.text "sources", default: [], array: true
    t.string "type"
    t.json "item_limit"
    t.json "type_limit"
    t.text "category_limit", default: [], array: true
    t.string "price_wepon_cat_mult", default: ""
    t.integer "price", default: 0, null: false
    t.integer "rarity", default: 0
    t.boolean "is_restricted", default: false
    t.integer "hard_points"
    t.integer "encumbrance"
    t.integer "min_enc"
    t.integer "max_enc"
    t.integer "min_soak"
    t.integer "max_soak"
    t.integer "min_encum_cap"
    t.integer "min_defense"
    t.boolean "must_have_hyperdrive"
    t.boolean "must_be_starship"
    t.boolean "jury_rigged"
    t.boolean "use_mod_price"
    t.boolean "price_pass_mult"
    t.integer "mod_price"
    t.integer "min_size"
    t.integer "max_size"
    t.boolean "is_crystal"
    t.boolean "price_size_mult"
    t.json "base_mods", default: []
    t.json "added_mods", default: []
    t.json "weapon_modifiers", default: []
    t.text "skill_limit", default: [], array: true
    t.string "image_filename", default: "missing.png"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "specialized_shop_id", null: false
    t.bigint "world_id", null: false
    t.string "shop_type"
    t.integer "boost_dice", default: 0
    t.integer "setback_dice", default: 0
    t.integer "characteristic_level", default: 0
    t.integer "skill_level", default: 0
    t.integer "min_size", default: 0
    t.integer "max_size", default: 1000
    t.text "sourcebooks", default: [], array: true
    t.jsonb "items", default: {}
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "challenge_dice", default: 0
    t.string "name"
    t.boolean "should_markup", default: true
    t.boolean "is_custom", default: false
    t.index ["slug"], name: "index_shops_on_slug", unique: true
    t.index ["specialized_shop_id"], name: "index_shops_on_specialized_shop_id"
    t.index ["user_id"], name: "index_shops_on_user_id"
    t.index ["world_id"], name: "index_shops_on_world_id"
  end

  create_table "source_books", force: :cascade do |t|
    t.string "key", null: false
    t.string "title", null: false
    t.string "collection"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specialized_shops", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.text "item_types", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_default", default: false, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_specialized_shops_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "stripe_subscription_id"
    t.datetime "billing_cycle_anchor"
    t.datetime "canceled_at"
    t.datetime "current_period_end"
    t.datetime "current_period_start"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_customer_id"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.boolean "allow_password_change", default: false
    t.jsonb "tokens"
    t.boolean "is_admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weapons", force: :cascade do |t|
    t.string "key"
    t.string "name"
    t.text "description"
    t.text "sources", default: [], array: true
    t.string "skill_key"
    t.boolean "is_restricted", default: false
    t.integer "damage"
    t.integer "damage_add"
    t.integer "crit"
    t.string "range_value"
    t.string "range"
    t.boolean "no_melee"
    t.integer "encumbrance"
    t.integer "hard_points"
    t.integer "price", default: 0
    t.integer "rarity", default: 0
    t.integer "size_low"
    t.integer "size_high"
    t.integer "attach_cost_mult"
    t.boolean "ordnance"
    t.string "hands"
    t.string "type"
    t.text "categories", default: [], array: true
    t.json "qualities", default: []
    t.json "base_mods", default: []
    t.json "weapon_modifiers", default: []
    t.string "image_filename", default: "missing.png"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "worlds", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "rarity_modifier", null: false
    t.integer "price_modifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_default", default: false, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_worlds_on_user_id"
  end

  add_foreign_key "shops", "specialized_shops"
  add_foreign_key "shops", "users"
  add_foreign_key "shops", "worlds"
  add_foreign_key "specialized_shops", "users"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "worlds", "users"
end
