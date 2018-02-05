class CreateUserProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_profiles do |t|
      t.integer  "account_id",  null: false
      t.timestamps
    end
  end
end
