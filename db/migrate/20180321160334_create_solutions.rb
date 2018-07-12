class CreateSolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :solutions, id: :uuid do |t|
      t.belongs_to :question, type: :uuid, null: false, foreign_key: true
      t.belongs_to :format, type: :uuid, null: false, foreign_key: true
      t.text :content, null: false
      t.belongs_to :member, type: :uuid, null: false, foreign_key: true
      t.timestamp :created_at, null: false
    end
  end
end
