class AddUsersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :user_type

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end