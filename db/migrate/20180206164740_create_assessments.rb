class CreateAssessments < ActiveRecord::Migration[5.1]
  def change

    create_table :assessments, id: :uuid do |t|
      t.string :source_identifier
      t.string :source_version
      t.uuid :a15k_identifier, null: false
      t.integer :a15k_version, null: false, default: 1
      t.belongs_to :member, type: :uuid, null: false, foreign_key: true
      t.text :fingerprint, null: false, index: true
      t.timestamp :created_at, null: false, index: true
    end

    add_index :assessments, [:a15k_identifier, :a15k_version], unique: true
    add_index :assessments, [:source_identifier, :member_id, :source_version], unique: true,
              name: :index_assessments_on_source_id_member_id_source_version
  end
end
