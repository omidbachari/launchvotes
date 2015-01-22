class RemoveStringFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :string, :string, null: false, default: 'user'
  end
end
