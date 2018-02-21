class CreateAssessments < ActiveRecord::Migration[5.1]
  def change
    create_table :assessments, id: :uuid do |t|
      t.belongs_to :organization, type: :uuid, null: false, foreign_key: true
      t.belongs_to :license, type: :uuid, null: false, foreign_key: true
      t.timestamp :created_at
    end
  end
end