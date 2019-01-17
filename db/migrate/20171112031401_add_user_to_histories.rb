class AddUserToHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :histories, :user, :integer
  end
end
