class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :email, null: false
      t.string :name, null: false
      t.string :pic_url, null: false
      t.timestamps
    end

    add_index :users, [:uid, :provider], unique: true
  end
end
