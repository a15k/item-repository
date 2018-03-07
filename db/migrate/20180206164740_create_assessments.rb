class CreateAssessments < ActiveRecord::Migration[5.1]
  def change

    create_table :assessments, id: :uuid do |t|
      t.integer :visibility, limit: 2 # smallint
      t.belongs_to :owner, type: :uuid, null: false, foreign_key: { to_table: :assessment_owners }
      t.belongs_to :format, type: :uuid, null: false, foreign_key: true
      t.belongs_to :created_by, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.timestamp :created_at, null: false, foreign_key: true, index: true
    end

    create_table :assessments_tags, id: :uuid do |t|
      t.belongs_to :tag, type: :uuid, null: false, foreign_key: true
      t.belongs_to :assessment, type: :uuid, null: false, foreign_key: true
    end

  end
end
