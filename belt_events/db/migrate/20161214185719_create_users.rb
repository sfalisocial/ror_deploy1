class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :location
      t.references :state, index: true
      t.string :password_digest

      t.timestamps null: false
    end
    add_foreign_key :users, :states
  end
end
