class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions, id: :uuid do |t|
      t.belongs_to :assessment, type: :uuid, null: false, foreign_key: true
      t.belongs_to :format, type: :uuid, null: false, foreign_key: true
      t.text :content, null: false
      t.text :variant_id, index: true
      t.belongs_to :created_by, type: :uuid, null: false, foreign_key: { to_table: :members }
      t.timestamp :created_at, null: false
    end
  end
end
