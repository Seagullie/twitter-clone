class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.integer :is_following

      t.timestamps
    end
  end
end
