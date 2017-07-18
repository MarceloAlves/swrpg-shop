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

ActiveRecord::Schema.define(version: 20170718044737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "armors", force: :cascade do |t|
    t.string "key", null: false
    t.string "name", null: false
    t.text "description"
    t.text "sources", default: [], array: true
    t.integer "defense", default: 0
    t.integer "soak", default: 0
    t.integer "price", default: 0, null: false
    t.integer "encumbrance", default: 0
    t.integer "hit_points", default: 0
    t.integer "rarity", default: 0
    t.text "categories", default: [], array: true
    t.boolean "is_restricted", default: false
    t.json "base_mods"
    t.json "weapon_modifiers"
    t.string "item_type"
    t.string "image_filename", default: "missing.png"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gears", force: :cascade do |t|
    t.string "key", null: false
    t.string "name", null: false
    t.text "description"
    t.string "short"
    t.string "gear_type"
    t.text "categories", default: [], array: true
    t.integer "encumbrance", default: 0
    t.integer "hit_points", default: 0
    t.integer "price", default: 0
    t.integer "rarity", default: 0
    t.boolean "is_restricted", default: false
    t.text "sources", default: [], array: true
    t.string "image_filename", default: "missing.png"
    t.json "base_mods"
    t.json "weapon_modifiers"
    t.string "adv_import_path"
    t.json "modifiers"
    t.string "item_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_attachments", force: :cascade do |t|
    t.string "key", null: false
    t.string "name", null: false
    t.text "description"
    t.text "sources", default: [], array: true
    t.string "item_attachment_type"
    t.json "item_limit"
    t.json "type_limit"
    t.text "category_limit", default: [], array: true
    t.string "price_wepon_cat_mult", default: ""
    t.integer "price", default: 0
    t.integer "rarity", default: 0
    t.boolean "restricted", default: false
    t.integer "hit_points", default: 0
    t.integer "encumbrance", default: 0
    t.integer "min_enc", default: 0
    t.integer "max_enc", default: 0
    t.integer "min_soak", default: 0
    t.integer "max_soak", default: 0
    t.integer "min_encum_cap", default: 0
    t.integer "min_defense", default: 0
    t.boolean "must_have_hyperdrive", default: false
    t.boolean "must_be_starship", default: false
    t.boolean "jury_rigged", default: false
    t.boolean "use_mod_price", default: false
    t.boolean "price_pass_mult", default: false
    t.integer "mod_price", default: 0
    t.integer "min_size", default: 0
    t.integer "max_size", default: 0
    t.boolean "is_crystal", default: false
    t.boolean "price_size_mult", default: false
    t.json "base_mods"
    t.json "added_mods"
    t.json "weapon_modifiers"
    t.text "skill_limit", default: [], array: true
    t.string "image_filename", default: "missing.png"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "source_books", force: :cascade do |t|
    t.string "key", null: false
    t.string "title", null: false
    t.string "collection"
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
  end

end
