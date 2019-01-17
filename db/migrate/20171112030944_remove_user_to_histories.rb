class RemoveUserToHistories < ActiveRecord::Migration[5.1]
  def change
    remove_column :histories, :user, :string
  end
end
