class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets, id: :uuid do |t|
      t.integer :size
      t.text :content
      t.text :content_type, null: false
      t.integer :type, null: false, limit: 2 # smallint
      t.belongs_to :assessment, type: :uuid, null: false, foreign_key: true
    end
  end
end
