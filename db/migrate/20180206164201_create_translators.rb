class CreateTranslators < ActiveRecord::Migration[5.1]
  def change
    create_table :translators, id: :uuid do |t|
      t.text :name, null: false
      t.text :url
      t.text :script
      t.text :interpreter
      t.belongs_to :input,  type: :uuid, null: false, foreign_key: { to_table: :formats }
      t.belongs_to :output, type: :uuid, null: false, foreign_key: { to_table: :formats }
    end
  end
end
