class RemoveNullConstraintsOnUserFields < ActiveRecord::Migration
  def up
    change_column :users, :uid, :integer, null: true
    change_column :users, :provider, :string, null: true
    change_column :users, :username, :string, null: true
    change_column :users, :pic_url, :string, null: true
  end

  def down
    change_column :users, :uid, :integer, null: true
    change_column :users, :provider, :string, null: true
    change_column :users, :username, :string, null: true
    change_column :users, :pic_url, :string, null: true
  end
end
