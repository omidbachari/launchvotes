class RemoveIndexOnUidAndProvider < ActiveRecord::Migration
  def up
    remove_index :users, [:uid, :provider]
  end

  def down
    add_index :users, [:uid, :provider], unique: true
  end
end
