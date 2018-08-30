class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.integer :expert_id
      t.string :tag
      t.string :content

      t.timestamps
    end
  end
end
