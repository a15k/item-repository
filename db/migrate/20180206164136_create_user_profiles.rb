class CreateUserProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_profiles, id: :uuid do |t|
      t.integer  "account_id",  null: false
      t.belongs_to :organization, type: :uuid, null: true, foreign_key: true
    end
  end
end
