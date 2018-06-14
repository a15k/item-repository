class CreateOpenStaxAccounts < ActiveRecord::Migration[5.1]
  def change
    enable_extension "plpgsql"
    enable_extension "pgcrypto"
    enable_extension "citext"

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

  end
end
