class CreateVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :variants, id: :uuid do |t|
      t.belongs_to :assessment, type: :uuid, null: false, foreign_key: true
      t.belongs_to :format, type: :uuid, null: false, foreign_key: true
      t.text :content, null: false
      t.text :variant_id, index: true
      t.timestamp :created_at, null: false
    end
  end
end
