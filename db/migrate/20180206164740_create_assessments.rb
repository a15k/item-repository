class CreateAssessments < ActiveRecord::Migration[5.1]
  def change

    create_table :assessments, id: :uuid do |t|
      t.text :member_version_stable_id, index: true
      t.text :member_version, index: true
      t.uuid :a15k_version_stable_id, null: false
      t.integer :a15k_version, null: false, default: 1
      t.belongs_to :member, type: :uuid, null: false, foreign_key: true
      t.text :fingerprint, null: false, index: true
      t.timestamp :created_at, null: false, index: true
      t.timestamp :submitted_to_metadata_at, null: true, index: true
    end

    add_index :assessments, [:a15k_version_stable_id, :a15k_version], unique: true
    add_index :assessments, [:member_version_stable_id, :member_version], unique: true
  end
end
