class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.integer  :account_id,  null: false
      t.integer :role, limit: 2, default: 1 # smallint
      t.belongs_to :member, type: :uuid, null: true, foreign_key: true
    end
  end
end
