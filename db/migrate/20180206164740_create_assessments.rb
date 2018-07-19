class CreateAssessments < ActiveRecord::Migration[5.1]
  def change

    create_table :assessments, id: :uuid do |t|
      t.string :identifier, index: true
      t.belongs_to :member, type: :uuid, null: false, foreign_key: true
      t.integer :version, null: false, default: 1
      t.integer :visibility, limit: 2 # smallint
      t.text :fingerprint, null: false, index: true
      t.text :preview_html
      t.timestamp :created_at, null: false, index: true
    end

    add_index :assessments, [:identifier, :version], unique: true
  end
end
