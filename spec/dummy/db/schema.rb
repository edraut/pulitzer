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

ActiveRecord::Schema.define(version: 20170602204900) do

  create_table "pulitzer_arrangement_styles", force: :cascade do |t|
    t.integer "post_type_id"
    t.string  "display_name"
    t.string  "view_file_name"
  end

  create_table "pulitzer_background_styles", force: :cascade do |t|
    t.integer "post_type_id"
    t.string  "display_name"
    t.string  "css_class_name"
  end

  create_table "pulitzer_content_element_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pulitzer_content_elements", force: :cascade do |t|
    t.string   "label"
    t.string   "title"
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
    t.integer  "partial_id"
    t.integer  "style_id"
    t.integer  "custom_option_id"
  end

  create_table "pulitzer_custom_option_lists", force: :cascade do |t|
    t.string "name"
  end

  create_table "pulitzer_custom_options", force: :cascade do |t|
    t.integer "custom_option_list_id"
    t.string  "display"
    t.string  "value"
  end

  create_table "pulitzer_free_form_section_types", force: :cascade do |t|
    t.integer "post_type_id"
    t.string  "name"
    t.integer "sort_order"
  end

  create_table "pulitzer_free_form_sections", force: :cascade do |t|
    t.integer "version_id"
    t.integer "free_form_section_type_id"
    t.string  "name"
  end

  create_table "pulitzer_justification_styles", force: :cascade do |t|
    t.integer "post_type_id"
    t.string  "display_name"
    t.string  "css_class_name"
  end

  create_table "pulitzer_partial_types", force: :cascade do |t|
    t.integer "free_form_section_type_id"
    t.string  "label"
    t.integer "sort_order"
    t.integer "layout_id"
    t.integer "post_type_id"
  end

  create_table "pulitzer_partials", force: :cascade do |t|
    t.integer "post_type_id"
    t.integer "free_form_section_id"
    t.integer "sort_order"
    t.integer "layout_id"
    t.string  "label"
    t.integer "background_style_id"
    t.integer "justification_style_id"
    t.integer "sequence_flow_style_id"
    t.integer "arrangement_style_id"
  end

  create_table "pulitzer_post_tags", force: :cascade do |t|
    t.integer  "version_id"
    t.integer  "label_id"
    t.string   "label_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pulitzer_post_type_content_element_type_custom_option_lists", force: :cascade do |t|
    t.integer "post_type_content_element_type_id"
    t.integer "custom_option_list_id"
  end

  create_table "pulitzer_post_type_content_element_types", force: :cascade do |t|
    t.integer  "post_type_id"
    t.integer  "content_element_type_id"
    t.string   "label"
    t.integer  "height",                  default: 100
    t.integer  "width",                   default: 100
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "text_editor"
    t.boolean  "required",                default: false
    t.integer  "sort_order"
    t.string   "clickable_kind",          default: "any", null: false
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
    t.index ["slug"], name: "index_pulitzer_posts_on_slug", unique: true
  end

  create_table "pulitzer_sequence_flow_styles", force: :cascade do |t|
    t.integer "post_type_id"
    t.string  "display_name"
    t.string  "css_class_name"
  end

  create_table "pulitzer_styles", force: :cascade do |t|
    t.integer "post_type_content_element_type_id"
    t.string  "display_name"
    t.string  "css_class_name"
  end

  create_table "pulitzer_tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "parent_id"
    t.boolean  "hierarchical", default: false, null: false
    t.index ["hierarchical"], name: "index_pulitzer_tags_on_hierarchical"
  end

  create_table "pulitzer_versions", force: :cascade do |t|
    t.integer  "status",         default: 0
    t.integer  "post_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "cloning_errors"
  end

end
