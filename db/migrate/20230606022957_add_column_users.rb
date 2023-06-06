class AddColumnUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_digest, :string, null: false, default: ""

    add_column :users, :activated, :boolean, null: false, default: false
  end
end
