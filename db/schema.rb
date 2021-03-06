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

ActiveRecord::Schema.define(version: 20150421020418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "attacks", force: :cascade do |t|
    t.string   "name"
    t.integer  "character_id"
    t.integer  "level_requirement"
    t.integer  "skill_point_cost"
    t.string   "attack_type"
    t.integer  "damage"
    t.integer  "healing"
    t.integer  "critical_multiplier"
    t.string   "removes_status"
    t.integer  "accuracy"
    t.boolean  "always_hits"
    t.boolean  "true_damage"
    t.integer  "recharge_time"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.string   "player_race"
    t.integer  "level"
    t.integer  "user_id"
    t.boolean  "boss"
    t.integer  "gold"
    t.integer  "experience"
    t.integer  "max_skill_points"
    t.integer  "skill_points"
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
    t.integer  "critical_chance"
    t.integer  "critical_modifier"
    t.integer  "initiative"
    t.integer  "hit_chance"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.hstore   "buffs",             default: {}, null: false
    t.hstore   "debuffs",           default: {}, null: false
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

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.integer  "attack_id"
    t.integer  "damage"
    t.integer  "healing"
    t.string   "status_type"
    t.boolean  "boss_applicable"
    t.boolean  "player_applicable"
    t.integer  "duration"
    t.integer  "duration_remaining"
    t.integer  "application_chance"
    t.string   "effect"
    t.string   "dispelled_by"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
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

  create_table "weapons", force: :cascade do |t|
    t.string   "name"
    t.string   "weapon_type"
    t.integer  "weight"
    t.integer  "character_id"
    t.integer  "attack"
    t.integer  "mending"
    t.integer  "power"
    t.integer  "defense"
    t.integer  "avoidance"
    t.integer  "resistance"
    t.string   "effect"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
