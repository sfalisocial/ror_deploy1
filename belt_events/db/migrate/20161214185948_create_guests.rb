class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.references :event, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :guests, :events
    add_foreign_key :guests, :users
  end
end
