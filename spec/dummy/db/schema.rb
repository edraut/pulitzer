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

ActiveRecord::Schema.define(version: 20160609214139) do

  create_table "pulitzer_content_element_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pulitzer_content_elements", force: :cascade do |t|
    t.string   "label"
    t.text     "body"
    t.string   "image"
    t.integer  "version_id"
    t.integer  "post_type_content_element_type_id"
    t.integer  "content_element_type_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "text_editor"
    t.integer  "height",                            default: 100
    t.integer  "width",                             default: 100
    t.integer  "sort_order"
    t.integer  "kind",                              default: 0
    t.integer  "partial_id"
  end

  create_table "pulitzer_free_form_section_types", force: :cascade do |t|
    t.integer "post_type_id"
    t.string  "name"
  end

  create_table "pulitzer_free_form_sections", force: :cascade do |t|
    t.integer "version_id"
    t.integer "free_form_section_type_id"
    t.string  "name"
  end

  create_table "pulitzer_layouts", force: :cascade do |t|
    t.integer "post_type_id"
    t.string  "name"
  end

  create_table "pulitzer_partials", force: :cascade do |t|
    t.integer "post_type_id"
    t.integer "free_form_section_id"
    t.integer "sort_order"
    t.integer "layout_id"
    t.string  "label"
  end

  create_table "pulitzer_post_tags", force: :cascade do |t|
    t.integer  "version_id"
    t.integer  "label_id"
    t.string   "label_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pulitzer_post_type_content_element_types", force: :cascade do |t|
    t.integer  "post_type_id"
    t.integer  "content_element_type_id"
    t.string   "label"
    t.integer  "height",                  default: 100
    t.integer  "width",                   default: 100
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "text_editor"
  end

  create_table "pulitzer_post_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "plural"
    t.integer  "kind",       default: 0
  end

  create_table "pulitzer_posts", force: :cascade do |t|
    t.string   "title"
    t.integer  "post_type_id"
    t.string   "status",       default: "unpublished"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "slug"
  end

  add_index "pulitzer_posts", ["slug"], name: "index_pulitzer_posts_on_slug", unique: true

  create_table "pulitzer_tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "parent_id"
    t.boolean  "hierarchical", default: false, null: false
  end

  add_index "pulitzer_tags", ["hierarchical"], name: "index_pulitzer_tags_on_hierarchical"

# Could not dump table "pulitzer_versions" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

end
