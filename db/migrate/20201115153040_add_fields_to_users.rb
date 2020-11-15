class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string

    add_index :users, :username, unique: true # what's that? index column?
  end
end
