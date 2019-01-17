class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.integer :timestamp
      t.string :url
      t.string :user

      t.timestamps
    end
  end
end
