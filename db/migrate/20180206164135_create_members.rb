class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members, id: :uuid do |t|
      t.text :name
      t.text :website
    end
  end
end
