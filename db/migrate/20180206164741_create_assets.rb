class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets, id: :uuid do |t|
      t.references :owner, polymorphic: true, null: false, index: true
      t.text :content_type, null: false
      t.jsonb :info, null: false, default: {}
      t.belongs_to :created_by, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.timestamp :created_at, null: false
    end

  end
end
