class CreateVersions < ActiveRecord::Migration[5.1]
  def change

    create_table :versions, id: :uuid do |t|
      t.integer :visibility, limit: 2 # smallint
      t.string :solution_key
      t.belongs_to :format, type: :uuid, null: false, foreign_key: true
      t.belongs_to :assessment, type: :uuid, null: false, foreign_key: true
      t.belongs_to :created_by, type: :uuid, null: false, foreign_key: { to_table: :user_profiles }

      t.timestamp :created_at, null: false, foreign_key: true
    end

    create_table :version_tags, id: :uuid do |t|
      t.belongs_to :tag, type: :uuid, null: false, foreign_key: true
      t.belongs_to :version, type: :uuid, null: false, foreign_key: true
    end

  end
end
