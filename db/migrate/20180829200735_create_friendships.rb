class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :expert_1_id
      t.integer :expert_2_id

      t.timestamps
    end
  end
end
