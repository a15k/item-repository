class CreateFormats < ActiveRecord::Migration[5.1]
  def change
    create_table :formats, id: :uuid do |t|
      t.text :name, null: false
      t.text :identifier, null: false
      t.text :specification, null: false
      t.timestamp :created_at, null: false, index: true
      t.belongs_to :created_by, type: :uuid, null: false, foreign_key: { to_table: :members }
    end
  end
end
