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

ActiveRecord::Schema.define(version: 20150318042540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.string   "player_class"
    t.string   "player_race"
    t.integer  "level"
    t.integer  "user_id"
    t.integer  "hitpoints"
    t.integer  "max_hitpoints"
    t.integer  "constitution"
    t.integer  "strength"
    t.integer  "agility"
    t.integer  "intelligence"
    t.integer  "faith"
    t.integer  "toughness"
    t.integer  "evasion"
    t.integer  "acuity"
    t.integer  "piety"
    t.integer  "initiative"
    t.integer  "hit_chance"
    t.string   "debuffs",                    array: true
    t.string   "buffs",                      array: true
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "weight"
    t.text     "description"
    t.string   "character_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "background_path"
    t.string   "coordinates",                  array: true
    t.integer  "enemy_types",                  array: true
    t.integer  "npc_types",                    array: true
    t.integer  "shop_types",                   array: true
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "characters",                   array: true
    t.integer  "bosses",                       array: true
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
