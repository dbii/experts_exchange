class CreateExperts < ActiveRecord::Migration[5.2]
  def change
    create_table :experts do |t|
      t.string :name
      t.string :url
      t.string :short_url

      t.timestamps
    end
  end
end
