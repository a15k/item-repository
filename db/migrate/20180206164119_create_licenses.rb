class CreateLicenses < ActiveRecord::Migration[5.1]
  def change
    create_table :licenses, id: :uuid do |t|
      t.text :abbreviation, null: false
      t.text :name, null: false
      t.text :url, null: false
      t.text :terms, null: false
    end
  end
end
