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

ActiveRecord::Schema.define(version: 2020_11_18_155008) do

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "soliloquy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_comments", force: :cascade do |t|
    t.text "comment"
    t.integer "user_id"
    t.integer "soliloquy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "soliloquies", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "object"
    t.text "what_do"
    t.text "how_feel"
    t.text "must_and_can"
    t.text "did_action"
    t.text "purpose_soliloquy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "last_name"
    t.string "first_name"
    t.string "kana_last_name"
    t.string "kana_first_name"
    t.text "introduction"
    t.string "profile_image_id"
    t.text "for_what_application"
    t.text "message_level"
    t.text "ignore_character"
    t.string "occupation"
    t.text "think_to_job"
    t.text "want_job_time"
    t.text "think_job_relationship"
    t.text "can_offer_job"
    t.string "target_income"
    t.text "what_want_learn"
    t.text "like_other_job"
    t.text "what_desire_love"
    t.text "how_did_life"
    t.text "past_failures"
    t.text "basic_experience"
    t.text "what_require"
    t.text "my_personality"
    t.text "can_offer_personality"
    t.text "request_relationship_spirit"
    t.text "interested_by_given"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end