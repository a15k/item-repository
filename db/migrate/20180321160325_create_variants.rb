class CreateVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :variants, id: :uuid do |t|
      t.belongs_to :assessment, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :format, type: :uuid, null: false, foreign_key: true
      t.text :content, null: false
      t.text :source_identifier, index: true
      t.text :preview_html
      t.timestamp :created_at, null: false
    end
  end
end
