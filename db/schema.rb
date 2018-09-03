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

ActiveRecord::Schema.define(version: 2018_09_02_214247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "access_tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "member_id"
    t.text "name", null: false
    t.datetime "created_at"
    t.index ["member_id"], name: "index_access_tokens_on_member_id"
  end

  create_table "assessments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "source_identifier"
    t.string "source_version"
    t.uuid "a15k_identifier", null: false
    t.integer "a15k_version", default: 1, null: false
    t.uuid "member_id", null: false
    t.text "fingerprint", null: false
    t.datetime "created_at", null: false
    t.datetime "submitted_to_metadata_at"
    t.index ["a15k_identifier", "a15k_version"], name: "index_assessments_on_a15k_identifier_and_a15k_version", unique: true
    t.index ["created_at"], name: "index_assessments_on_created_at"
    t.index ["fingerprint"], name: "index_assessments_on_fingerprint"
    t.index ["member_id"], name: "index_assessments_on_member_id"
    t.index ["source_identifier", "member_id", "source_version"], name: "index_assessments_on_source_id_member_id_source_version", unique: true
    t.index ["submitted_to_metadata_at"], name: "index_assessments_on_submitted_to_metadata_at"
  end

  create_table "assets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
    t.text "content_type", null: false
    t.jsonb "info", default: {}, null: false
    t.uuid "created_by_id", null: false
    t.datetime "created_at", null: false
    t.index ["created_by_id"], name: "index_assets_on_created_by_id"
    t.index ["owner_type", "owner_id"], name: "index_assets_on_owner_type_and_owner_id"
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

  create_table "formats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "identifier", null: false
    t.text "specification", null: false
    t.datetime "created_at", null: false
    t.uuid "created_by_id", null: false
    t.index ["created_at"], name: "index_formats_on_created_at"
    t.index ["created_by_id"], name: "index_formats_on_created_by_id"
  end

  create_table "licenses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "abbreviation", null: false
    t.text "name", null: false
    t.text "url", null: false
    t.text "terms", null: false
  end

  create_table "members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name"
    t.text "website"
  end

  create_table "openstax_accounts_accounts", id: :serial, force: :cascade do |t|
    t.integer "openstax_uid"
    t.string "username"
    t.string "access_token"
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "faculty_status", default: 0, null: false
    t.string "salesforce_contact_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.integer "role", default: 0, null: false
    t.citext "support_identifier"
    t.boolean "is_test"
    t.index ["access_token"], name: "index_openstax_accounts_accounts_on_access_token", unique: true
    t.index ["faculty_status"], name: "index_openstax_accounts_accounts_on_faculty_status"
    t.index ["first_name"], name: "index_openstax_accounts_accounts_on_first_name"
    t.index ["full_name"], name: "index_openstax_accounts_accounts_on_full_name"
    t.index ["last_name"], name: "index_openstax_accounts_accounts_on_last_name"
    t.index ["openstax_uid"], name: "index_openstax_accounts_accounts_on_openstax_uid", unique: true
    t.index ["role"], name: "index_openstax_accounts_accounts_on_role"
    t.index ["salesforce_contact_id"], name: "index_openstax_accounts_accounts_on_salesforce_contact_id"
    t.index ["support_identifier"], name: "index_openstax_accounts_accounts_on_support_identifier", unique: true
    t.index ["username"], name: "index_openstax_accounts_accounts_on_username", unique: true
    t.index ["uuid"], name: "index_openstax_accounts_accounts_on_uuid", unique: true
  end

  create_table "openstax_accounts_group_members", id: :serial, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "user_id"], name: "index_openstax_accounts_group_members_on_group_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_openstax_accounts_group_members_on_user_id"
  end

  create_table "openstax_accounts_group_nestings", id: :serial, force: :cascade do |t|
    t.integer "member_group_id", null: false
    t.integer "container_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["container_group_id"], name: "index_openstax_accounts_group_nestings_on_container_group_id"
    t.index ["member_group_id"], name: "index_openstax_accounts_group_nestings_on_member_group_id", unique: true
  end

  create_table "openstax_accounts_group_owners", id: :serial, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "user_id"], name: "index_openstax_accounts_group_owners_on_group_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_openstax_accounts_group_owners_on_user_id"
  end

  create_table "openstax_accounts_groups", id: :serial, force: :cascade do |t|
    t.integer "openstax_uid", null: false
    t.boolean "is_public", default: false, null: false
    t.string "name"
    t.text "cached_subtree_group_ids"
    t.text "cached_supertree_group_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_public"], name: "index_openstax_accounts_groups_on_is_public"
    t.index ["openstax_uid"], name: "index_openstax_accounts_groups_on_openstax_uid", unique: true
  end

  create_table "solutions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "variant_id", null: false
    t.uuid "format_id", null: false
    t.text "content", null: false
    t.uuid "member_id", null: false
    t.datetime "created_at", null: false
    t.index ["format_id"], name: "index_solutions_on_format_id"
    t.index ["member_id"], name: "index_solutions_on_member_id"
    t.index ["variant_id"], name: "index_solutions_on_variant_id"
  end

  create_table "translators", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "url"
    t.text "script"
    t.text "interpreter"
    t.uuid "input_id", null: false
    t.uuid "output_id", null: false
    t.index ["input_id"], name: "index_translators_on_input_id"
    t.index ["output_id"], name: "index_translators_on_output_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "role", limit: 2, default: 1
    t.uuid "member_id"
    t.index ["member_id"], name: "index_users_on_member_id"
  end

  create_table "variants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "assessment_id", null: false
    t.uuid "format_id", null: false
    t.text "content", null: false
    t.text "source_identifier"
    t.text "preview_html"
    t.datetime "created_at", null: false
    t.index ["assessment_id"], name: "index_variants_on_assessment_id"
    t.index ["format_id"], name: "index_variants_on_format_id"
    t.index ["source_identifier"], name: "index_variants_on_source_identifier"
  end

  add_foreign_key "access_tokens", "members"
  add_foreign_key "assessments", "members"
  add_foreign_key "assets", "members", column: "created_by_id"
  add_foreign_key "formats", "members", column: "created_by_id"
  add_foreign_key "solutions", "formats"
  add_foreign_key "solutions", "members"
  add_foreign_key "solutions", "variants", on_delete: :cascade
  add_foreign_key "translators", "formats", column: "input_id"
  add_foreign_key "translators", "formats", column: "output_id"
  add_foreign_key "users", "members"
  add_foreign_key "variants", "assessments", on_delete: :cascade
  add_foreign_key "variants", "formats"
end
