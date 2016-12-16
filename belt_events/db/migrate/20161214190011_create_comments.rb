class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :event, index: true
      t.references :user, index: true
      t.string :content

      t.timestamps null: false
    end
    add_foreign_key :comments, :events
    add_foreign_key :comments, :users
  end
end
