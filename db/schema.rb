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

ActiveRecord::Schema.define(version: 20150402121549) do

  create_table "answers", force: true do |t|
    t.text     "text",        default: "", null: false
    t.integer  "correct",     default: 0,  null: false
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "competences", force: true do |t|
    t.string   "code",        default: "", null: false
    t.string   "description", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.text     "text",       default: "", null: false
    t.integer  "difficulty", default: 0,  null: false
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["topic_id"], name: "index_questions_on_topic_id"

  create_table "questions_variants", id: false, force: true do |t|
    t.integer  "variant_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions_variants", ["variant_id", "question_id"], name: "index_questions_variants_on_variant_id_and_question_id", unique: true

  create_table "results", force: true do |t|
    t.integer  "variant_id"
    t.integer  "user_id"
    t.integer  "assessment", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statistics", force: true do |t|
    t.integer  "result_id"
    t.integer  "topic_id"
    t.float    "ratio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", force: true do |t|
    t.text     "text",                        null: false
    t.integer  "on",              default: 0, null: false
    t.integer  "variants_count",  default: 0, null: false
    t.integer  "questions_count", default: 0, null: false
    t.integer  "minutes",         default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "text",       default: "", null: false
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["parent_id"], name: "index_topics_on_parent_id"

  create_table "topics_competences", id: false, force: true do |t|
    t.integer  "topic_id"
    t.integer  "competence_id"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics_competences", ["competence_id"], name: "index_topics_competences_on_competence_id"
  add_index "topics_competences", ["topic_id"], name: "index_topics_competences_on_topic_id"

  create_table "user_sessions", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_sessions", ["user_id"], name: "index_user_sessions_on_user_id"

  create_table "users", force: true do |t|
    t.string   "login",                   null: false
    t.string   "password",                null: false
    t.string   "name",       default: "", null: false
    t.string   "surname",    default: "", null: false
    t.string   "group",      default: "", null: false
    t.integer  "teacher",    default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true

  create_table "variants", force: true do |t|
    t.integer  "test_id"
    t.integer  "number",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "variants", ["test_id", "number"], name: "index_variants_on_test_id_and_number"

end
