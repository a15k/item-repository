class CreateAssessments < ActiveRecord::Migration[5.1]
  def change

    create_table :assessments, id: :uuid do |t|
      t.string :identifier, index: true
      t.string :version, null: false, index: true, default: '1'
      t.integer :visibility, limit: 2 # smallint
      t.belongs_to :format, type: :uuid, null: false, foreign_key: true
      t.text :preview_html
      t.belongs_to :created_by, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.timestamp :created_at, null: false, index: true
    end

  end
end
