class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags, id: :uuid do |t|
      t.text :name, null: false
      t.belongs_to :organization, type: :uuid, null: false, foreign_key: true
    end
  end
end
