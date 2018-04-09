class CreateFormats < ActiveRecord::Migration[5.1]
  def change
    create_table :formats, id: :uuid do |t|
      t.text :name, null: false
      t.text :identifier, null: false
      t.text :description, null: false
    end
  end
end
